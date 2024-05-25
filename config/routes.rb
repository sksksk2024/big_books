# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  namespace :api do
    namespace :v1 do
      resources :books do
        resources :authors, only: [:new, :create, :update, :edit] # Include :edit action for editing authors
      end
    end
  end

  # Remove duplicate resources :authors and resources :books
  resources :authors
  # resources :books  # Remove this line

  get 'home/about'
  get 'top_authors/index'
  
  root 'api/v1/books#index' # Adjusted root path
  #delete '/users/sign_out', to: 'sessions#destroy'

  namespace :admin do
    resources :roles, only: [:edit, :update]
  end

end



