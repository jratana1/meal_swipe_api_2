class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:edit, :update]

  # GET /restaurants
  def swipe
    results = YelpApiAdaptor.api_search(params[:location],params[:term], params[:offset], params[:latitude], params[:longitude])
    render json: results
  end

  def swiperight
    rest_attr = YelpApiAdaptor.yelp_rest_hash_converter(restaurant_params)
    restaurant = Restaurant.create_with(name: params["restaurant"]["name"]).find_or_create_by(yelp_id: params["restaurant"]["id"])
   
    RestaurantUser.create(restaurant_id:restaurant.id, user_id:current_user.id)

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

  # # GET /restaurants/new
  # def new
  #   @restaurant = Restaurant.new
  # end

  # # GET /restaurants/1/edit
  # def edit
  # end

  # # POST /restaurants
  # def create
  #   @restaurant = Restaurant.new(restaurant_params)

  #   if @restaurant.save
  #     redirect_to @restaurant, notice: 'Restaurant was successfully created.'
  #   else
  #     render :new
  #   end
  # end

  # # PATCH/PUT /restaurants/1
  # def update
  #   if @restaurant.update(restaurant_params)
  #     redirect_to @restaurant, notice: 'Restaurant was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:yelp_id])
    end

    # Only allow a trusted parameter "white list" through.
    def restaurant_params
      params.require(:restaurant).permit(:yelp_id, :id, :name, :state, :postal_code, :address, :display_phone, :location => {}, :photos => [])
    end
end
