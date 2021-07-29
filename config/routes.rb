Rails.application.routes.draw do

  get '/authenticate-google', to: 'sessions#authenticate_google'
  get '/authenticate-facebook', to: 'sessions#authenticate_facebook'
  get 'auth/:provider/callback', to: 'users#create'
  get 'auth/failure' => 'users#index'
  get '/load', to: 'sessions#load'
  get '/guestLogin', to: 'sessions#guestLogin'


  post '/swipe' => 'restaurants#swipe'
  post '/swiperight' => 'restaurants#swiperight'
  
  resources :likes, only: [:create, :destroy]
  resources :restaurants
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
