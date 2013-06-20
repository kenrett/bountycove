module UsersHelper

  def current_user
    @current_user ||= User.find_by_username(session[:user_id])
  end

  def current_user_is_pirate
    current_user.is_a_pirate?
  end
  
  def count_of_available_tasks(user)
    user.tasks.count(:conditions => "status = 1")
  end

  def current_user_is_captain
    current_user.is_a_captain?
  end
  
  def current_user_tasks_assigned(status)
    current_user.tasks.where(status: status)
  end

  def render_local_pirate_or_captain_view(action)
    render "captain.#{action}.html.haml" if current_user_is_captain
    render "pirate.#{action}.html.haml" if current_user_is_pirate
  end

  def pirate_captain_profile_link
    current_user_is_pirate ? pirate_path(current_user) : captain_path(current_user)
  end

end
