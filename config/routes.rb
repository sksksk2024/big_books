# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :books do
    resources :authors, only: [:create, :update, :edit] # Include :edit action for editing authors
  end

  resources :authors
  resources :books

  get 'home/about'
  root 'books#index'
  delete '/users/sign_out', to: 'sessions#destroy'
end


