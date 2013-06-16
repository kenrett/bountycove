class Task < ActiveRecord::Base
  attr_accessible :worth, :name, :description

  belongs_to :captain
  belongs_to :pirate

  validates :name, :presence => true
  validate :name, :format => { :with => /(\D+)/ }
  validates :description, :presence => true
  validates :description, :format => { :with => /\w+/ }
  validates :worth, :presence => true, :numericality => { :only_integer => true }

  STATUS = {on_board: 1, assigned: 2, completed: 3}

  STATUS.each do |key, value|
    define_method("#{key.to_s}?") { status == value }
    define_method("#{key.to_s}!") { self.status = value; self.save }
  end

  def string?

  end 
end
