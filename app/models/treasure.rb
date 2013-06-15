class Treasure < ActiveRecord::Base
  attr_accessible :name, :description, :photo, :price
  validates :name, :uniqueness => true
  validates :photo, :uniqueness => true
  validates :name, :description, :price, :presence => true, :on => :create

  belongs_to :captain

end
