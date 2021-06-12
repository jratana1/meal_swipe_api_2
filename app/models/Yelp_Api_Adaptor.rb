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
    
   
end