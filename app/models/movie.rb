class Movie < ApplicationRecord
    
    has_many :reviews
    
    scope :set_average_ratings, ->  do
        all.each do |movie|
            s = movie.reviews.sum(:stars)
            c = movie.reviews.count
            movie.update_attribute(:average_rating, c == 0 ? 0.0 : s / c.to_f)   
        end
    end

    def self.search(query)
         where(actor: query)
    end

end
