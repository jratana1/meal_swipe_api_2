class Restaurant < ApplicationRecord
    has_many :restaurant_users, dependent: :destroy
    has_many :users, through: :restaurant_users

    has_many :likes, dependent: :destroy
    has_many :liking_users, :through => :likes, :source => :user

    has_and_belongs_to_many :categories

end
