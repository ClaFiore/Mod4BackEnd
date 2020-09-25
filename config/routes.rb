Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tables
      resources :restaurants
      resources :reservations
      resources :users
    end
  end
end
