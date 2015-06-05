Registrar::Engine.routes.draw do
  root "sessions#new"

  get "/auth/google/callback", to: "sessions#create"

  resource :sessions, only: [:new, :create, :destroy]
end
