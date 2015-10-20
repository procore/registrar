Rails.application.routes.draw do
  mount Registrar::Engine, at: '/'

  resources :sessions, only: [:new, :create]
end
