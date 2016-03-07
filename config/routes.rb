Rails.application.routes.draw do

  resources :users, only: [:edit, :update]
  resources :events, only: [:create]

  root "welcome#home"
  get "/login", to: "sessions#create"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/dashboard", to: "users#dashboard"
  get "/scheduler", to: "users#scheduler"
  get '/auth/meetup/callback', to: 'sessions#create'
end
