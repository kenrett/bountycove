class CreateChildSti < ActiveRecord::Migration
  def change
    add_column :users, :type, :string
    add_column :users, :captain_id, :integer
  end
end
