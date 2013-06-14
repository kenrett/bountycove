class Child < User
  belongs_to :parents, :foreign_key => :parent_id

  def parent?
    false
  end
end
