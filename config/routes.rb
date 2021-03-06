Rails.application.routes.draw do

  resources :books
  resources :groups
  resources :authors
  root 'home#index'
  devise_for :users
  resources :users, only: [:index, :edit, :destroy, :show]
  post "/users/:id/edit", to:"users#update"
end
