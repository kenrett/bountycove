class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :username, :null => false
      t.string :email
      t.string :password_digest, :null => false

      t.timestamps
    end
  end
end
