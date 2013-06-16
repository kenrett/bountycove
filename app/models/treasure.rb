class Treasure < ActiveRecord::Base
  attr_accessible :name, :description, :photo, :price
  validates :name, :description, :price, :presence => true, :on => :create

  belongs_to :captain
  belongs_to :pirate

  STATUS = {on_sale: 1, bought: 2, delivered: 3}

  STATUS.each do |key, value|
    define_method("#{key.to_s}?") { status == value }
    define_method("#{key.to_s}!") { self.status = value; self.save }
  end
end
