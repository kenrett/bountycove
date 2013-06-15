module UsersHelper 

  def current_user
    @user ||= @user.find(session[:user_id])
  end

end
