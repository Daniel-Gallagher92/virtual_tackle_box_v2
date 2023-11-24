class CreateLures < ActiveRecord::Migration[7.0]
  def change
    create_table :lures do |t|
      t.string :brand
      t.string :variety
      t.string :color
      t.float :weight
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
