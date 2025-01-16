Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "invoices#index"
  # Authentication routes
  resource :session
  resources :passwords, param: :token
  # Application routes
  get "profile", to: "companies#profile"
  get "statistics", to: "companies#statistics"
  resources :companies, only: [ :edit, :update ]
  resources :clients, only: [ :index, :new, :create, :edit, :update ] do
    member { post "invoice" }
  end
  resources :invoices, only: [ :index, :show, :destroy ] do
    resources :invoice_items, only: [ :create ]
    member { patch "issue" }
  end
  resources :invoice_items, only: [ :edit, :update, :destroy ] do
    member do
      post "duplicate"
      patch "move"
      patch "increment"
    end
  end
end
