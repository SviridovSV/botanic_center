Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'registrations',
    omniauth_callbacks: "users/omniauth_callbacks" }

  root 'home_page#index'

  resources :categories, only: [:show], path: 'catalog'
  resources :books, only: [:show]
  resources :reviews, only: [:create]
end
