class CreateCatches < ActiveRecord::Migration[7.0]
  def change
    create_table :catches do |t|
      t.string :species
      t.float :weight
      t.float :length
      t.references :user, null: false, foreign_key: true
      t.string :spot_name
      t.float :latitude
      t.float :longitude
      t.string :lure
      t.string :cloudinary_urls

      t.timestamps
    end
  end
end
