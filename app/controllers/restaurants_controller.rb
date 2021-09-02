class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:edit, :update]

  # GET /restaurants
  def swipe
    filter = ""  
    params[:filter].except(:location, :term, :openNow).each do |key, value|
      if value 
        if filter.blank?
          filter = "#{key}"
        else
          filter += ",#{key}"
        end
      end
    end


    if params[:location].blank?
      results = YelpApiAdaptor.api_search(params[:location], filter, params[:offset], params[:filter][:openNow], params[:latitude], params[:longitude] )
      render json: results
    else
      results = YelpApiAdaptor.api_search(params[:location],filter, params[:offset], params[:filter][:openNow])
      render json: results
    end

  end

  def swiperight
    restaurant = Restaurant.create_with(name: params["restaurant"]["name"], city: params["restaurant"]["location"]["city"]).find_or_create_by(yelp_id: params["restaurant"]["id"])
    
    RestaurantUser.create(restaurant_id:restaurant.id, user_id:current_user.id)

    params["restaurant"]["categories"].each do |category|
      category = Category.create_with(alias: category["alias"]).find_or_create_by(title: category["title"])
      restaurant.categories << category
    end

    render json: current_user.restaurants
  end

  def index
    #need to set current user
    user= current_user
    render json: user.restaurants
  end

  # GET /restaurants/1
  def show
    results = YelpApiAdaptor.api_business(params[:id])

    render json: results 
  end

    # DELETE /restaurants/1
    def destroy
      restaurant = Restaurant.find_by(yelp_id: params[:id])
      like = Like.find_by(restaurant_id: restaurant.id, user_id: current_user.id)
      
      RestaurantUser.find_by(restaurant_id: restaurant.id, user_id: current_user.id).destroy
      
      if like
        like.destroy
      end
  
      render json: current_user.restaurants
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:yelp_id])
    end

    # Only allow a trusted parameter "white list" through.
    def restaurant_params
      params.require(:restaurant).permit(:yelp_id, :id, :name, :state, :postal_code, :address, :display_phone, :location => {}, :photos => [], :categories => [])
    end
end
