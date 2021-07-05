class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  def swipe
    results = YelpApiAdaptor.api_search("philly")
    render json: results 
  end

  def swiperight
     #need to change to current user
    rest_attr = YelpApiAdaptor.yelp_rest_hash_converter(restaurant_params)
    restaurant = Restaurant.find_or_create_by(yelp_id: params["restaurant"]["id"])
    restaurant.update(rest_attr)
   
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
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      redirect_to @restaurant, notice: 'Restaurant was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /restaurants/1
  def update
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: 'Restaurant was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /restaurants/1
  def destroy
    @restaurant.destroy
    redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def restaurant_params
      params.require(:restaurant).permit(:id, :name, :state, :postal_code, :address, :display_phone, :location => {}, :photos => [])
    end
end
