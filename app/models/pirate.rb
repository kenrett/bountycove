# Child

class Pirate < User

  belongs_to :captain, :foreign_key => :captain_id
  has_many :treasures


  def validate_email?
    email.present?
  end

  def to_param
    username.downcase
  end
end
