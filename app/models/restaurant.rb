class Restaurant < ApplicationRecord
    has_many :restaurant_users, dependent: :destroy
    has_many :users, through: :restaurant_users

    has_many :likes, dependent: :destroy
    has_many :liked_users, :through => :likes, :source => :user
end
