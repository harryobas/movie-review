Rails.application.routes.draw do

    resources :movies, only: [:index, :show] do
        collection do
            get 'search'
            get 'sort'
        end
    end
  
end
