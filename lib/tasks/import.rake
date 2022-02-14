
namespace :import do
  require 'csv'
  
  desc "Create Models from csv files"
  
  task csv_import: :environment do
    converter = lambda do |header|
      return header.downcase if header.split(' ').size == 1
      header.downcase.split(' ').join("_")
    end
    csv = File.read("#{Rails.root}/reviews.csv")
    reviews = CSV.parse(csv, headers: true, header_converters: converter)
    .map{|x| x}
    CSV.foreach("#{Rails.root}/movies.csv", headers: true, header_converters: converter) do |row|
      m = Movie.create(row.to_h)

      review = reviews.shift(2)
      if review && review.size == 1
        rev = review.pop
        if rev['movie'] == m.movie
          r = Review
          .new(user: rev['user'], stars: rev['stars'], review: rev['review'])
          m.reviews << r 
        else
          reviews.unshift(rev)
        end
      elsif review && review.size == 2
        rev1 = review[0]
        rev2 = review[1]
        if rev1['movie'] == m.movie && rev2['movie'] == m.movie 
          r1 = Review
          .new(user: rev1['user'], stars: rev1['stars'], review: rev1['review'])
          r2 = Review
          .new(user: rev2['user'], stars: rev2['stars'], review: rev2['review'])
          m.reviews << r1 
          m.reviews << r2 
        elsif rev1['movie'] == m.movie && !(rev2['movie'] == m.movie)
          r = Review
          .new(user: rev1['user'], stars: rev1['stars'], review: rev1['review'])
          m.reviews << r 
          reviews.unshift(rev2)
        else
          r = Review
          .new(user: rev2['user'], stars: rev2['stars'], review: rev2['review'])
          m.reviews << r 
          reviews.unshift(rev1)
        end
      else
        next 
      end
    end
    Movie.set_average_ratings
  end
end















