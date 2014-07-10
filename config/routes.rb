require 'sidekiq/web'
Pingpong::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

	root to: "users#index"

  resources :matches do
    member do
      get :play
    end

    collection do
      get "pending", to: "matches#pending_matches"
    end
  end

  as :user do
    get "/login" => "devise/sessions#new", as: :new_user_session
    post "/login" => "devise/sessions#create", as: :user_session
    delete "/logout" => "devise/sessions#destroy", as: :destroy_user_session
  end


  devise_for :users, skip: [:sessions], controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  as :user do
    get "/register", to: "devise/registrations#new", as: :register
    get "/login", to: "devise/sessions#new", as: :login
    get "/logout", to: "devise/sessions#destroy", as: :logout
  end

  get "/leaderboard" => "users#index", as: :leaderboard

  resources :tournaments do
    resources :matches do
      member do
        get :play
      end

      collection do
        get "pending", to: "matches#pending_matches"
      end
    end
  end
end
