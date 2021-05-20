class Restaurant < ApplicationRecord
    has_many :restaurant_users, dependent: :destroy
    has_many :users, through: :restaurant_users
end
