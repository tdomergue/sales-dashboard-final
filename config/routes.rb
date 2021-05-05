Rails.application.routes.draw do
  get 'countries/index'
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'

  namespace :api do
    namespace :v1 do
      resources :countries, only: [:index]
      get '/customers/:country', to: 'customers#number_per_country'
      get '/orders/:country', to: 'orders#revenue_per_country'
      get '/orders/:country/average', to: 'orders#average_revenue_per_country'
      get '/orders/:country/monthly', to: 'orders#revenue_per_month'
    end
  end

end
