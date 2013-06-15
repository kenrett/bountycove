class CreatePirate < ActiveRecord::Migration
  def change
    create_table :pirates do |t|
      t.string :name, :null => false
      t.string :username, :null => false
      t.string :email
      t.string :password_digest 

      t.timestamps
    end
  end
end
