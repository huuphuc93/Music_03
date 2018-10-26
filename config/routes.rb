Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  get root to: "pages#home"
  get "/search", to: "searchs#search"
  get "password_reset/new"
  get "password_reset/edit"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/songs", to: "songs#audio_download"
  post "/next", to: "lyrics#next"
  post "/previus", to: "lyrics#previus"
  post "/login", to: "sessions#create"
  post "songs/next", to: "songs#next"
  delete "/logout", to: "sessions#destroy"
  resources :account_activations, only: :edit
  resources :songs, only: :show
  resources :lyrics, only: :create
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users, except: :index
  resources :lyrics, only: :create
  resources :comments
  resources :favorite_lists
  resources :favorites, only: [:create, :destroy]
  resources :ratings, only: :create
  resources :albums, only: :show
  resources :categories, only: :show
  resources :artists, only: :show
  match "/auth/facebook/callback", to: "omniauth_callbacks#facebook",
    via: [:get, :post]
  match "auth/failure", to: redirect("/"), via: [:get, :post]
  namespace :admin do
    root to: "users#index"
    resources :songs
    resources :categories
    resources :users, except: :show
    resources :albums
    resources :artists
    resources :lyrics
  end
end
