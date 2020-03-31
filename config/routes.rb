Rails.application.routes.draw do
  get 'users/show'

  resources :users, only: [:show]

  # ログイン、アカウント編集後、任意のページに遷移させるための記述
  # devise_for :users, controllers: {
  #         registrations: 'users/registrations'
  # }

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
  root 'home#index'
end
