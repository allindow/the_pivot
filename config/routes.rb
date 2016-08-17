Rails.application.routes.draw do

  root "organizations#index"

  resources :recipients, only: [:index, :show]
  resources :organizations, only: [:new, :create, :index]  
  resources :carts, only: [:create]
  resources :users, only: [:new, :create, :show, :destroy]
  resources :fundings, only: [:index, :create, :show, :new, :create]

  namespace :funding do
    resources :charges, only: [:new, :create]
  end

  namespace :admin do
    resources :dashboard, only: [:index, :edit, :update, :new, :create]
    resources :recipients, only: [:index, :edit, :update]
  end

  namespace :organizations, path: ':organization_slug' do
    resources :recipients, param: :slug, only: [:show]
  end

  post "/login", to: "sessions#create"
  get "/login", to: "sessions#new"
  delete "/logout", to: "sessions#destroy"
  get '/dashboard', to: "users#show"

  put "/cart", to: "carts#update"
  delete "/cart", to: "carts#destroy"
  get "/cart", to: "carts#index"
  get "/:slug", to: "organizations#show"
  get "/:organization_slug/:slug", to: "organizations/recipients#show"
  # get "*path" => redirect('/')
end
