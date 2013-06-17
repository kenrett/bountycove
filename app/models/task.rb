class Task < ActiveRecord::Base
  attr_accessible :worth, :name, :description#, :captain_id, :pirate_id
  belongs_to :captain
  belongs_to :pirate

  validates :name, :presence => true
  validate :name, :format => { :with => /(\D+)/ }
  validates :description, :presence => true
  validates :description, :format => { :with => /\w+/ }
  validates :worth, :presence => true, :numericality => { :only_integer => true }

  ON_BOARD    = 1
  ASSIGNED    = 2
  NEED_VERIFY = 3
  COMPLETED   = 4

  STATUS = { on_board: ON_BOARD,
             assigned: ASSIGNED,
             need_verify: NEED_VERIFY,
             completed: COMPLETED}

  STATUS.each do |key, value|
    define_method("#{key.to_s}?") { status == value }
    define_method("#{key.to_s}!") { self.status = value; self.save }
  end
end
