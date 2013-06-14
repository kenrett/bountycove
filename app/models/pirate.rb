# Child
class Pirate < User
  belongs_to :captains, :foreign_key => :parent_id

  def parent?
    false
  end
end
