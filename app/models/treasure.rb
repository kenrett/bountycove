class Treasure < ActiveRecord::Base
  attr_accessible :name, :description, :photo, :price, :status
  
  validates :name, :description, :presence => true, :on => :create
  validates :name, :format => { :with => /(\D+)/ }
  validates :description, :format => { :with => /\w+/ }
  validates :price, :format => { :with => /\d/ }
  validates :price,
              :presence => true,
              :numericality => { :only_integer => true },
              :if => :validate_price?

  belongs_to :captain
  belongs_to :pirate

  STATUS = {wish_list: 0, on_sale: 1, bought: 2, delivered: 3}

  STATUS.each do |key, value|
    define_method("#{key.to_s}?") { status == value }
    define_method("#{key.to_s}!") { self.status = value; self.save }
  end

  def validate_price?
    status == 1
  end
end
