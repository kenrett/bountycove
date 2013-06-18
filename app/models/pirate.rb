# Child

class Pirate < User

  belongs_to :captain, :foreign_key => :captain_id
  has_many :treasures
  has_many :tasks

  has_many :treasures_on_wishlist,
                                  :source => :treasures,
                                  :class_name => 'Treasure',
                                  :conditions => {:status => Treasure::WISHLIST}
  has_many :treasures_bought,
                                  :source => :treasures,
                                  :class_name => 'Treasure',
                                  :conditions => {:status => Treasure::BOUGHT}
  has_many :treasures_received,
                                  :source => :treasures,
                                  :class_name => 'Treasure',
                                  :conditions => {:status => Treasure::DELIVERED}

  def captain
    self.captain
  end

  def validate_email?
    email.present?
  end

  def to_param
    username.downcase
  end
end
