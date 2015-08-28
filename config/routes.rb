Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update, :show, :index]

  get 'welcome/about'
  root to: 'welcome#index'

end
