Rails.application.routes.draw do
  root to: "home#index"
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: "users/sessions",
  }
  resources :users, param: :name do
    resource :followings, only: [:index, :show]
    resource :followers, only: [:index, :show]
  end
  
  resources :tweets do
  	resource :favorites, only: [:create, :destroy]
  	resource :retweets, only: [:create, :destroy]
  	resource :bads, only: [:create, :destroy]
    resource :replies, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: :index
  resources :rankings, only: :index
end