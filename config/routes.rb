Rails.application.routes.draw do
#Devise routes
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


  namespace :api do 
    namespace :v2 do 
      resources :forecasts, only: [:index]
      resources :go_fish, only: [:create]
      resources :users, only: [:create] do 
        resources :catches, only: [:create, :index, :show, :update, :destroy]
        resources :lures, only: [:create, :index, :show, :update, :destroy]
      end
      get 'current_user', to: 'current_user#index'
    end
  end
    # root "articles#index"
end
