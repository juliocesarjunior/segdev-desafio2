Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/calculate', to: 'risk_score#calculate_score'
  post '/users', to: 'users#create'
end
