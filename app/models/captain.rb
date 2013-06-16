# Parent

class Captain < User
  has_many :pirates
  has_many :treasures
  has_many :tasks

  def validate_email?
    true
  end

  def to_param
    username
  end
end
