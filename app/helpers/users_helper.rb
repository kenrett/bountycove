module UsersHelper

  def current_user
    @current_user ||= User.find_by_username(session[:user_id])
  end

  def current_user_is_pirate
    current_user.type == 'Pirate'
  end

  def current_user_is_captain
    current_user.type == 'Captain'
  end
end
