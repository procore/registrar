Registrar::Engine.routes.draw do
  root "sessions#new"

  get "/auth/google/callback", to: "sessions#create"

  get Registrar.configuration&.signin_url, to: "sessions#new", as: "signin"
  match Registrar.configuration&.signout_url, via: [:get, :delete], to: "sessions#destroy", as: "signout"
end
