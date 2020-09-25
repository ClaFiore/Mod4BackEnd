Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tables
      get '/restaurants/:start', to: 'restaurants#index'
      resources :restaurants
      resources :reservations
      resources :users
    end
  end
end
