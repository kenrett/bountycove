class Treasure < ActiveRecord::Base
  attr_accessible :name, :description, :photo, :price
  validates :name, :description, :price, :presence => true, :on => :create

  belongs_to :captain
  belongs_to :pirate
end
