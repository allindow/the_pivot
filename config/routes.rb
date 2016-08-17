Rails.application.routes.draw do

  root to: "recipients#index"

  resources :recipients, only: [:index, :show]
  resources :organizations, only: [:show, :new]
  resources :carts, only: [:create]
  resources :users, only: [:new, :create, :show, :destroy]
  resources :fundings, only: [:index, :create, :show, :new, :create]

  namespace :country, path: ":country_slug", as: :country do
    get '/needs', to: "recipients#index"
  end

  namespace :funding do
    resources :charges, only: [:new, :create]
  end

  namespace :admin do
    resources :dashboard, only: [:index, :edit, :update, :new, :create]
    resources :recipients, only: [:index, :edit, :update]
  end

  post "/login", to: "sessions#create"
  get "/login", to: "sessions#new"
  delete "/logout", to: "sessions#destroy"
  get '/dashboard', to: "users#show"

  put "/cart", to: "carts#update"
  delete "/cart", to: "carts#destroy"
  get "/cart", to: "carts#index"
  get "/:name", to: "types#show"
  # get "*path" => redirect('/')
end
