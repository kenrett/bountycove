class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :username, :email, :password
  has_secure_password
end
