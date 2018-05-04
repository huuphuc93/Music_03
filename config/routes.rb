Rails.application.routes.draw do
  get root to: "pages#home"
  get "password_reset/new"
  get "password_reset/edit"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users, except: :index
  match "/auth/facebook/callback", to: "omniauth_callbacks#facebook", via: [:get, :post]
  match "auth/failure", to: redirect("/"), via: [:get, :post]
end
