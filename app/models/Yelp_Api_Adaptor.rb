class YelpApiAdaptor < ApplicationRecord
    API_HOST = "https://api.yelp.com"
    SEARCH_PATH = "/v3/businesses/search"
    BUSINESS_PATH = "/v3/businesses/"
    SEARCH_LIMIT = 50
    API_URL = "https://api.yelp.com/v3/graphql"
    
    def self.api_search(location, categories = "restaurants", offset = 1)
      body = "{search(term: \"food\", location: \"#{location}\", categories: \"#{categories}\", limit: 50, offset: #{offset}) {business {id, name, location{address1, city, state, postal_code}, photos}}}"
      response = HTTP.auth("Bearer #{ENV['API_KEY']}").headers("Content-Type" => "application/graphql").post("https://api.yelp.com/v3/graphql", :body => body)
      response.parse["data"]["search"]["business"]
    end
    
    def self.api_business(business_id)
      body = "{business(id: \"#{business_id}\") {id, name}}"
      response = HTTP.auth("Bearer #{ENV['API_KEY']}").headers("Content-Type" => "application/graphql").post("https://api.yelp.com/v3/graphql", :body => body)
      response.parse
    end
    
    def self.yelp_rest_hash_converter(hash)
        rest_hash = {}
        rest_hash[:name] = hash["name"]
        rest_hash[:address] = hash["location"]["address1"]
        rest_hash[:city] = hash["location"]["city"]
        rest_hash[:state] = hash["location"]["state"]
        rest_hash[:postal_code] = hash["location"]["postal_code"]
        rest_hash[:yelp_id] = hash["id"]
        rest_hash[:photos] = hash["photos"][0]
        rest_hash
    end

    def self.yelp_cat_hash_converter(hash)
      @category_array = hash["categories"]
    end

    def self.make_restauarant(restaurant)
        @rest_hash = YelpApiAdaptor.yelp_rest_hash_converter(restaurant)
        @cat_hash = YelpApiAdaptor.yelp_cat_hash_converter(restaurant)    
        if @rest_hash[:image_url] && !Restaurant.find_by_yelp_id(@rest_hash[:yelp_id])
          restaurant = Restaurant.create(@rest_hash)            
          restaurant.photos << Photo.create(url:restaurant.image_url)          
          @cat_hash.each do |hash|
            restaurant.categories << Category.create_with(hash).find_or_create_by(title: hash["title"])
            end
        end
    end      
end