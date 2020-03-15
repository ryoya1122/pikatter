Rails.application.routes.draw do
  root to: "home#index"
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: "users/sessions",
  }
  resources :users, param: :name
  
  resources :tweets do
  	resource :favorites, only: [:create, :destroy]
  	resource :retweets, only: [:create, :destroy]
  	resource :bads, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: :index
end