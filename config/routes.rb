Rails.application.routes.draw do
  get 'users/show'
  # ログイン、アカウント編集後、任意のページに遷移させるための記述
  # devise_for :users, controllers: {
    #         registrations: 'users/registrations'}
  root 'home#index'
  get '/suggest', to: "suggests#suggest"
  post '/suggest', to: "suggests#suggest"

  devise_for :companies, controllers: {
    sessions:      'companies/sessions',
    passwords:     'companies/passwords',
    registrations: 'companies/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  resources :users, only: [:show]
  resources :companies, only: [:show]
  resources :microposts do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
  resources :notifications, only: :index
end
