class CreateItem < ActiveRecord::Migration
  def change 
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :photo
      t.string :price
      t.integer :parent_id

      t.timestamps
    end
  end
end
