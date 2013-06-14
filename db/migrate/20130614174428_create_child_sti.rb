class CreateChildSti < ActiveRecord::Migration
  def change
    add_column :users, :type, :string
    add_column :users, :parent_id, :integer
  end
end
