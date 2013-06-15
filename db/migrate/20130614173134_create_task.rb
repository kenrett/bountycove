class CreateTask < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :worth, :captain_id
      t.string :name, :description
      t.timestamps
    end
  end
end
