class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :username, :email, :password, :password_confirmation, :name

  validates :username, :uniqueness => true, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email,
            :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                         :on => :create },
            :if => :validate_email?
  validates :password, :presence => true, :on => :create

  has_secure_password

  def name
    "#{first_name} #{last_name}"
  end

  def name=(name)
    full_name       = name.gsub(/\W/, ' ').split

    self.first_name = full_name[0..-2].join(' ')
    self.last_name  = full_name.last
  end

  def is_a_captain?
    type == 'Captain'
  end

  def is_a_pirate?
    type =='Pirate'
  end
end
