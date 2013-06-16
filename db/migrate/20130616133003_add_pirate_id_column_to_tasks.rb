class AddPirateIdColumnToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :pirate_id, :integer
    add_column :tasks, :status, :integer, :default => 1
  end
end
