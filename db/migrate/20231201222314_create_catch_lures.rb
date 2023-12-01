class CreateCatchLures < ActiveRecord::Migration[7.0]
  def change
    create_table :catch_lures do |t|
      t.references :catch, null: false, foreign_key: true
      t.references :lure, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
