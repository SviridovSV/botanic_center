Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: { registrations:      'registrations',
                                    sessions:           'sessions',
                                    omniauth_callbacks: 'users/omniauth_callbacks'}

  devise_scope :user do
    put 'address_settings', to: 'registrations#address_settings'
  end

  root 'home_page#index'

  resources :categories, only: [:show], path: 'catalog'
  resources :books, only: [:show]
  resources :reviews, only: [:create]
  resources :order_items, only: [:create, :update, :destroy]
  resources :checkouts
  resource  :cart, only: [:show, :update]
  resources :orders, only: [:show, :index]
  resources :orders do
    get 'continue_shopping', on: :member
  end
end
