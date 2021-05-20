class User < ApplicationRecord
    has_many :restaurant_users
    has_many :restaurants, through: :restaurant_users
end
