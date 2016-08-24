Rails.application.routes.draw do

  root "organizations#index"

  resources :recipients
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

  namespace :platform do
    resources :dashboard, only: [:index]
    resources :fundings, only: [:index]
    resources :organizations, only: [:index, :update]
    namespace :organization do
      resources :users, param: :organization_slug, only: [:new]
    end
  end

  namespace :admin do
    resources :dashboard, only: [:index, :edit, :update, :new, :create]
    resources :recipients, only: [:index, :edit, :update]
  end

  patch '/admin/:organization_slug/recipients/:id', to: "admin/organization/recipients#update"
  get '/admin/:organization_slug/recipients', to: "admin/organization/recipients#index"
  get '/admin/:organization_slug/users', to: "admin/organization/users#index"
  get '/admin/:organization_slug/users/new', to: "admin/organization/users#new"
  patch '/users', to: "users#update"
  get '/:organization_slug/recipients/new', to: "organizations/recipients#new"

  namespace :organizations, path: ':organization_slug' do
    resources :recipients, param: :slug, only: [:show]
  end

  get '/:organization_slug/dashboard', to: "organizations/dashboard#index", as: 'organization_dashboard'

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
