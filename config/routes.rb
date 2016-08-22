Rails.application.routes.draw do

  root "organizations#index"

  resources :recipients, only: [:index, :show, :create, :destroy]
  resources :organizations, only: [:new, :create, :index]
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

  get '/admin/:organization_slug/recipients', to: "admin/organization/recipients#index"
  get '/:organization_slug/recipients/new', to: "organizations/recipients#new"

  namespace :organizations, path: ':organization_slug' do
    resources :recipients, param: :slug, only: [:show]
  end


  get '/:organization_slug/dashboard', to: "organizations/dashboard#index"

  post "/login", to: "sessions#create"
  get "/login", to: "sessions#new"
  delete "/logout", to: "sessions#destroy"
  get '/dashboard', to: "users#show"

  put "/cart", to: "carts#update"
  delete "/cart", to: "carts#destroy"
  get "/cart", to: "carts#index"
  get "/:slug", to: "organizations#show", as: 'organization'
  get "/:organization_slug/:slug", to: "organizations/recipients#show"
  patch "/organizations/:id", to: "organizations#update"
  get "*path" => redirect('/')
  
end
