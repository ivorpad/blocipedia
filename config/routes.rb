Rails.application.routes.draw do

  get 'users/update'

  devise_for :users

  resources :users, only: [:update, :show, :index]
  resources :wikis
  resources :charges, only: [:new, :create]

  get 'welcome/about'
  root to: 'welcome#index'

end
