class Treasure < ActiveRecord::Base
  attr_accessible :name, :description, :photo, :price, :status, :tax

  validates :name, :description, :presence => true, :on => :create
  validates :description, :format => { :with => /\w+/ }
  validates :price,
              :format => { :with => /\d/ },
              :if => :validate_price?
  validates :price,
              :presence => true,
              :numericality => { :only_integer => true, :greater_than => 0 },
              :if => :validate_price?

  belongs_to :captain
  belongs_to :pirate

  WISHLIST  = 0
  ON_SALE   = 1
  BOUGHT    = 2
  DELIVERED = 3

  STATUS = { wishlist: WISHLIST,
             on_sale: ON_SALE,
             bought: BOUGHT,
             delivered: DELIVERED}

  STATUS.each do |key, value|
    define_method("#{key.to_s}?") { status == value }
    define_method("#{key.to_s}!") { self.status = value; self.save }
  end

  def validate_price?
    status == 1
  end

  def total_price
    price + tax
  end
end
