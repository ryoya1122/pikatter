Rails.application.routes.draw do
  root to: "home#index"
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: "users/sessions",
  }
  resources :users, param: :name
  
  resources :tweets do
  	resource :favorites, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end