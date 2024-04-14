Rails.application.routes.draw do
  devise_for :users
  resources :books
  #get 'home/index'
  get 'home/about'
  #root 'home#index'
  root 'books#index'
end
