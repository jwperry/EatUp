Rails.application.routes.draw do

  resources :users, only: [:edit, :update]

  root "welcome#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/dashboard", to: "users#dashboard"
  get '/auth/:provider/callback', to: 'sessions#create'
end
