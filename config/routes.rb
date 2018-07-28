Rails.application.routes.draw do
  get 'groups/new'
  get 'groups/show'
  get 'groups/edit'
  get 'groups/index'
  resources :authors
  root 'home#index'
  devise_for :users

end
