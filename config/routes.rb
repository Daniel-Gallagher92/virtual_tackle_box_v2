Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do 
    namespace :v2 do 
      # resources :sessions, only: [:create]
      resources :users, only: [:create] do 
        resources :catches, only: [:create, :index, :show, :update, :destroy]
        resources :lures, only: [:create, :index, :show, :update, :destroy]
      end
    end
  end
end
