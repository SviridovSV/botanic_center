Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'home_page#index'

  resources :categories, only: [:show], path: 'catalog'
  resources :books, only: [:show]
end
