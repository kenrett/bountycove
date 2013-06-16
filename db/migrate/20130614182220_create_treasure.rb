class CreateTreasure < ActiveRecord::Migration
  def change
    create_table :treasures do |t|
      t.string :name
      t.string :description
      t.string :photo
      t.integer :price
      t.integer :captain_id
      t.integer :pirate_id
      t.integer :status

      t.timestamps
    end
  end
end
