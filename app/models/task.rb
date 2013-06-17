class Task < ActiveRecord::Base
  attr_accessible :worth, :name, :description

  belongs_to :captain
  belongs_to :pirate

  validates :name, :presence => true
  validate :name, :format => { :with => /(\D+)/ }
  validates :description, :presence => true
  validates :description, :format => { :with => /\w+/ }
  validates :worth, :presence => true, :numericality => { :only_integer => true }

  ON_BOARD  = 1
  ASSIGNED  = 2
  COMPLETED = 3

  STATUS = { on_board: ON_BOARD,
             assigned: ASSIGNED,
             completed: COMPLETED}

  STATUS.each do |key, value|
    define_method("#{key.to_s}?") { status == value }
    define_method("#{key.to_s}!") { self.status = value; self.save }
  end
end
