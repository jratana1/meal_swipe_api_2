class User < ApplicationRecord
    has_many :restaurant_users, dependent: :destroy
    has_many :restaurants, through: :restaurant_users

    has_many :likes, dependent: :destroy
    has_many :liked_restaurants, :through => :likes, :source => :restaurant

    has_friendship
end
