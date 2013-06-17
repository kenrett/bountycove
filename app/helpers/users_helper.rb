module UsersHelper

  def current_user
    @current_user ||= User.find_by_username(session[:user_id])
  end

  def current_user_is_pirate
    current_user.is_a_pirate?
  end

  def current_user_is_captain
    current_user.is_a_captain?
  end

  def render_local_pirate_or_captain_view(action)
    render "captain.#{action}.html.haml" if current_user_is_captain
    render "pirate.#{action}.html.haml" if current_user_is_pirate
  end
end
