Registrar::Engine.routes.draw do
  root "sessions#new"

  get "/auth/google/callback", to: "sessions#create"

  get "/signin", to: "sessions#new"
  get "/signout", to: "sessions#destroy"

  resource :sessions, only: [:new, :create, :destroy]
end
