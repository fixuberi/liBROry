Rails.application.routes.draw do
  resources :books
  resources :groups
  resources :authors
  root 'home#index'
  devise_for :users

end
