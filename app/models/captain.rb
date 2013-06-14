# Parent
class Captain < User
  has_many :pirates

  def parent?
    true
  end
end
