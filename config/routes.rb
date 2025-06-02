require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq", :constraints => SidekiqConstraint.new # mount Sidekiq::Web in your Rails app

  resource :session, only: %i[create destroy]
  resources :passwords, param: :token, only: %i[create update]
  resource :user, only: %i[create] do
    scope module: :users do
      resource :profile, only: %i[show update]
      resources :images, only: %i[index create destroy]
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
