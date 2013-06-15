# Parent
class Captain < User
  has_many :pirates

  def parent?
    true
  end

  def to_param
    username
  end
end
