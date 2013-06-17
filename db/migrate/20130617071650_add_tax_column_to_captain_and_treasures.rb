class AddTaxColumnToCaptainAndTreasures < ActiveRecord::Migration
  def change
    add_column :users, :tax_rate, :integer, :default => 5
    add_column :treasures, :tax, :integer
  end
end
