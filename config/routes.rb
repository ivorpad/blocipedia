Rails.application.routes.draw do

  get 'users/update'

  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :users, only: [:update, :show, :index]
  resources :wikis
  resources :charges, only: [:new, :create]
  resources :collaborators, only: [:create]

  delete '/downgrade', to: 'charges#downgrade'

  get 'welcome/about'
  root to: 'welcome#index'

end
