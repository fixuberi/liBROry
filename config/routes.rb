Rails.application.routes.draw do
  resources :authors
  root 'home#index'
  devise_for :users

end
