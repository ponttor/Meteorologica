Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :measurements, only: [:create]
      resources :temperature_profiles, only: [:index]
    end
  end
end
