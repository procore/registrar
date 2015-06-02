ProcoreUsers::Engine.routes.draw do
  root "sessions#new"

  get "/auth/google/callback", to: "sessions#create"

  resources :sessions, only: [:new, :create]
end
