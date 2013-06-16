class SessionController < ApplicationController

  def login
    @user = User.find_by_username(params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.username
      redirect_to captain_path(@user) if @user.is_a_captain?
      redirect_to pirate_path(@user) if @user.is_a_pirate?
    else
      flash[:errors_login] = ["Invalid username or password"]
      redirect_to root_path
    end
  end

  def logout
    session.clear
    flash[:logout] = ['Ye has left us!']
    redirect_to root_path
  end
end
