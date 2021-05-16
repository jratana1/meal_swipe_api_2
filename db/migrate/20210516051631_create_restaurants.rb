class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :yelp_id
      t.string :name
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :address
      t.string :display_phone
      t.string :photos

      t.timestamps
    end
  end
end
