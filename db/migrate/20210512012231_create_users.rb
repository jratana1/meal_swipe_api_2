class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :provider
      t.string :uid
      t.string :providerImage, default: "https://icon-library.net//images/no-user-image-icon/no-user-image-icon-27.jpg"

      t.timestamps
    end
  end
end
