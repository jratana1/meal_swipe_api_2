class SessionsController < ApplicationController
  def authenticate_facebook
    redirect_to '/auth/facebook' 
  end

  def authenticate_google
    redirect_to '/auth/google_oauth2'
  end

  def load
    user= current_user
    if user.restaurants? 
    render json: {:restaurants => user.restaurants, :likes => user.likes}
  end
end