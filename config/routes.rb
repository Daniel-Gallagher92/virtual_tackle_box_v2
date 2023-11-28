Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do 
    namespace :v2 do 
      resources :users, only: [:create] do 
        resources :catches, only: [:create, :index, :show, :update, :destroy]
        resources :lures, only: [:create, :index, :show, :update, :destroy]
      end
    end
  end
end
