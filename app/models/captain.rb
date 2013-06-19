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
  def to_param
    username.downcase
  end
end
