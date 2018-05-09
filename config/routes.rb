Rails.application.routes.draw do
  get root to: "pages#home"
  get "password_reset/new"
  get "password_reset/edit"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :account_activations, only: [:edit]
  resources :password_resets, except: [:destroy, :show, :index]
  resources :users, except: :index
end
