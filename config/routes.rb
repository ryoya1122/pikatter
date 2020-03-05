Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: "users/sessions",
  }

  resources :users, param: :name
  resources :tweets

end