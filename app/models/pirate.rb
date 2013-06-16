# Child
class Pirate < User
  belongs_to :captain, :foreign_key => :parent_id

  def parent?
    false
  end
end
