class Task < ActiveRecord::Base
  attr_accessible :worth, :name, :description

  belongs_to :captain

  validates :worth, :presence => true, :numericality => { :only_integer => true }
  validates :description, :presence => true
end
