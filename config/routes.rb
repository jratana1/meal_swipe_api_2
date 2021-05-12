Rails.application.routes.draw do
  get '/authenticate-google', to: 'sessions#authenticate_google'
  get '/authenticate-facebook', to: 'sessions#authenticate_facebook'
  get 'auth/:provider/callback', to: 'users#create'
  # post 'auth/request', to:'users#google_oauth2'
  # get '/auth/facebook/callback' => 'users#create'
  get 'auth/failure' => 'users#index'
  
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
