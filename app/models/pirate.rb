# Child

class Pirate < User

  belongs_to :captain, :foreign_key => :captain_id


  def parent?
    false
  end

  def to_param
    username
  end
end
