# Parent
class Captain < User
  has_many :pirates
  has_many :treasures
  
  def parent?
    true
  end

  def to_param
    username
  end
end
