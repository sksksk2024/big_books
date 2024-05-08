# frozen_string_literal: true

Rails.application.routes.draw do
  #binding.pry
  devise_for :user

  resources :books do
    resources :authors, only: [:new, :create, :update, :edit] # Include :edit action for editing authors
  end

  # Remove duplicate resources :authors and resources :books
  resources :authors
  # resources :books  # Remove this line

  get 'home/about'
  get 'top_authors/index'
  
  root 'books#index'
  #delete '/users/sign_out', to: 'sessions#destroy'
end



