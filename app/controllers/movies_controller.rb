class MoviesController < ApplicationController
    
    def index
        @movies = Movie.all
    end

    def search
        if params[:search].present?
            @movies = Movie.search(params[:search])
        else
            redirect_to  movies_path
        end
    end

    def show
        @movie = Movie.find(params[:id])
    end

    def sort
        @movies = Movie.order(average_rating: :desc)
    end

end
