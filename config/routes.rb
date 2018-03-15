Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users

  root to: 'pages#home'
  get '/billboard', to: 'pages#billboard', as: 'billboard'

  resources :users
  resources :postings, only: [:destroy, :create] do
    resources :pairings, only: [:create]
  end
  resources :pairings, only: [:show] do
    resources :messages, only: [:create]
  end

  get "/pairings/:id/accept", to: 'pairings#accept', as: 'accept'
  get "/pairings/:id/decline", to: 'pairings#decline', as: 'decline'

  resources :movies do
    member do
      post :filter_theaters
      post :filter_shows
    end
  end

  get "/dashboard", to: 'users#dashboard'


end

