Rails.application.routes.draw do

  root to: "recipients#index"

  resources :recipients, only: [:index, :show]
  resources :types, only: [:show]  
  resources :carts, only: [:create]
  resources :users, only: [:new, :create, :show, :destroy]
  resources :orders, only: [:index, :create, :show, :new, :create]
  
  namespace :order do 
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