# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper_openid_connect
  use_doorkeeper do
    controllers applications: 'oauth_applications'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # Project administration via UI
  resources :projects

  namespace :api do
    namespace :v1 do
      resources :projects
      get '/me' => 'credentials#me'
    end
  end

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
