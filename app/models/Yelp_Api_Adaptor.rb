class YelpApiAdaptor < ApplicationRecord
    API_HOST = "https://api.yelp.com"
    SEARCH_PATH = "/v3/businesses/search"
    BUSINESS_PATH = "/v3/businesses/"
    SEARCH_LIMIT = 10
    API_URL = "https://api.yelp.com/v3/graphql"
    
    def self.api_search(location, categories = "restaurants", offset = 1, latitude = 0, longitude = 0)
      body = "{search(term: \"food\", location: \"#{location}\", categories: \"#{categories}\", limit: 10, offset: #{offset}, latitude: #{latitude}, longitude: #{longitude}) {business {id, name, location{address1, city, state, postal_code}, photos}}}"
      response = HTTP.auth("Bearer #{ENV['API_KEY']}").headers("Content-Type" => "application/graphql").post("https://api.yelp.com/v3/graphql", :body => body)
      response.parse["data"]["search"]["business"]
    end
    
    def self.api_business(business_id)
      body = "{business(id: \"#{business_id}\") {id, name, phone, display_phone, url, rating, location{address1, city, state, postal_code}, reviews{text}, photos}}"
      response = HTTP.auth("Bearer #{ENV['API_KEY']}").headers("Content-Type" => "application/graphql").post("https://api.yelp.com/v3/graphql", :body => body)
      response.parse
    end
    
    def self.yelp_rest_hash_converter(hash)
      rest_hash = {}
      rest_hash[:name] = hash["name"]
      rest_hash[:display_phone] = hash["display_phone"]
      rest_hash[:address] = hash["location"]["address1"]
      rest_hash[:city] = hash["location"]["city"]
      rest_hash[:state] = hash["location"]["state"]
      rest_hash[:postal_code] = hash["location"]["postal_code"]
      rest_hash[:yelp_id] = hash["id"]
      rest_hash[:photos] = hash["photos"][0]
      rest_hash
  end
end