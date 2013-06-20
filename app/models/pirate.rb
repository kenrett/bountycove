# Child

class Pirate < User
  MAX = 4

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
  has_many :tasks_on_board,
                                  :source => :tasks,
                                  :class_name => 'Task',
                                  :conditions => {:status => Task::ON_BOARD}
  has_many :tasks_assigned,
                                  :source => :tasks,
                                  :class_name => 'Task',
                                  :conditions => {:status => Task::ASSIGNED}
  has_many :tasks_need_verify,
                                  :source => :tasks,
                                  :class_name => 'Task',
                                  :conditions => {:status => Task::NEED_VERIFY}
  has_many :tasks_completed,
                                  :source => :tasks,
                                  :class_name => 'Task',
                                  :conditions => {:status => Task::COMPLETED}

  def treasures_purchaseable
    self.captain.treasures.on_sale
  end

  def validate_email?
    self.email.present?
  end

  def to_param
    self.username.downcase
  end
end
