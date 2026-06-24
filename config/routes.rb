Rails.application.routes.draw do
  get "welcome/index"
  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "welcome#index"

  resources :events do
    resources :participations, only: [ :create, :destroy ]
  end

  get "/auth/:provider/callback", to: "sessions#create"
  post "/auth/:provider/callback", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resource :retirement, only: [ :new, :destroy ]
end
