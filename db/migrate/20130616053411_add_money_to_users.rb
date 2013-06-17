class AddMoneyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :coins, :integer, :default => 0
  end
end
