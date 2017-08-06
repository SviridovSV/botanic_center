Rails.application.routes.draw do
  devise_for :users

  root 'home_page#index'

  resources :categories, only: [:show], path: 'catalog'
  resources :books, only: [:show]
end
