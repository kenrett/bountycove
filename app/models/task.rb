class Task < ActiveRecord::Base
  attr_accessible :worth, :name, :description, :worth

  ON_BOARD    = 1
  ASSIGNED    = 2
  NEED_VERIFY = 3
  COMPLETED   = 4

  belongs_to :captain
  belongs_to :pirate

  scope :on_board,    where(status: ON_BOARD)
  scope :assigned,    where(status: ASSIGNED)
  scope :need_verify, where(status: NEED_VERIFY)
  scope :completed,   where(status: COMPLETED)

  validates :name, :presence => true
  validate :name, :format => { :with => /(\D+)/ }
  validates :description, :presence => true
  validates :description, :format => { :with => /\w+/ }
  validates :worth, :presence => true,
            :numericality => { :only_integer => true, :greater_than => 0 }

  STATUS = { on_board: ON_BOARD,
             assigned: ASSIGNED,
             need_verify: NEED_VERIFY,
             completed: COMPLETED}

  STATUS.each do |key, value|
    define_method("#{key.to_s}?") { status == value }
    define_method("#{key.to_s}!") { self.status = value; self.save }
  end
  

end
