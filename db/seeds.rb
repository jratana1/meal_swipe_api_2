# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require "securerandom"

# generate 20 users
(1..20).each do |id|
    User.create!(
# each user is assigned an id from 1-20
        name: Faker::Name.name,
        email: Faker::Internet.email,
        provider: "google",
        uid: SecureRandom.uuid
    )
end
