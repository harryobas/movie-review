
namespace :import do
  require 'csv'
  
  desc "Create Models from csv files"
  
  task csv_import: :environment do
    converter = lambda do |header|
      return header.downcase if header.split(' ').size == 1
      header.downcase.split(' ').join("_")
    end
    csv = File.read("#{Rails.root}/reviews.csv")
    reviews = CSV.parse(csv, headers: true, header_converters: converter).map{|x| x}
    CSV.foreach("#{Rails.root}/movies.csv", headers: true, header_converters: converter) do |row|
      m = Movie.create(row.to_h)
      review = reviews.shift unless reviews.empty? 
      if review && m.movie == review['movie'] 
        r = Review.new(user: review['user'], stars: review['stars'], review: review['review'])
        m.reviews << r  
      elsif review && !(m.movie == review['movie'])
        reviews.unshift(review)
      else
        next
      end  
    end
    Movie.set_average_ratings
  end 

end
   
