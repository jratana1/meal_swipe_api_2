class User < ApplicationRecord
    has_many :restaurant_users, dependent: :destroy
    has_many :restaurants, through: :restaurant_users
end
