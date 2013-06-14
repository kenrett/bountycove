class SessionController < ApplicationController

  def login
    @user = User.find_by_username(params[:username])
    
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      render :json => user_path(@user).to_json
    else
      @user.errors.delete(:password_digest)
      errors = render_to_string(:partial => 'shared/signup_errors', :locals => {:user => @user})
      render :json => 'Invalid username or password', :status => :unprocessable_entity
    end
  end

  def logout
    session.clear
    redirect_to root_path
  end

end
