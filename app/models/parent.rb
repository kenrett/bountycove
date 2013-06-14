class Parent < User
  has_many :children

  def parent?
    true
  end
end
