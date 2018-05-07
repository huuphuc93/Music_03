Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  post "/next", to: "lyrics#next"
  post "/previus", to: "lyrics#previus"
  get root to: "pages#home"
  get "/search", to: "searchs#search"
  get "password_reset/new"
  get "password_reset/edit"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :account_activations, only: :edit
  resources :songs, only: :show do
    resources :lyrics, only: :create
  end
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users, except: :index
  resources :lyrics, only: :create
  resources :comments
  match "/auth/facebook/callback", to: "omniauth_callbacks#facebook",
    via: [:get, :post]
  match "auth/failure", to: redirect("/"), via: [:get, :post]
end
