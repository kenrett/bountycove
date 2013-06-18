# Parent

class Captain < User
  has_many :pirates
  has_many :treasures
  has_many :tasks

  has_many :treasures_on_sale,
                                  :source => :treasures,
                                  :class_name => 'Treasure',
                                  :conditions => {:status => Treasure::ON_SALE}
  has_many :treasures_to_deliver,
                                  :source => :treasures,
                                  :class_name => 'Treasure',
                                  :conditions => {:status => Treasure::BOUGHT}
  has_many :treasures_delivered,
                                  :source => :treasures,
                                  :class_name => 'Treasure',
                                  :conditions => {:status => Treasure::DELIVERED}

  def validate_email?
    true
  end

  def to_param
    username.downcase
  end
end
