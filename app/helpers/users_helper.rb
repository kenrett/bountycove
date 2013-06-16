module UsersHelper 

  def current_user
    @current_user ||= User.find_by_username(session[:user_id])
  end

end
