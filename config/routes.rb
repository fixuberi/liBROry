Rails.application.routes.draw do
  resources :groups
  resources :authors
  root 'home#index'
  devise_for :users

end
