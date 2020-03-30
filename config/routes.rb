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
    post '/replies/', to: 'replies#create', :as => :replies
    delete '/replies/id', to: 'replies#destroy', :as => :replies_d
  end

  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: :index
  resources :rankings, only: :index

  get '/settings', to: 'settings#index'
  get '/settings/negablock', to: 'settings#negablock'
  get '/settings/negastrict', to: 'settings#negastrict'
  get '/settings/privacy', to: 'settings#privacy'
  get '/settings/withdraw', to: 'settings#withdraw'
  get '*path', to: 'application#render_404'
end