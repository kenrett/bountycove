class Task < ActiveRecord::Base
  attr_accessible :worth, :name, :description

  belongs_to :captain, :foreign_key => :user_id

  validates :worth, :presence => true
  validates :name, :uniqueness => true
  validates :description, :presence => true

end
