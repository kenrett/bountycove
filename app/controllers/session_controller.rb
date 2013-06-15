class SessionController < ApplicationController

  def login
    @user = User.find_by_username(params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      
      if @user.type == 'Captain'
        redirect_to captain_path(@user.username)
      else
        redirect_to captain_pirate_path(@user.username)
      end
    else
      flash[:errors_login] = ["Invalid username or password"]
      redirect_to root_path
    end
  end

  def logout
    session.clear
    redirect_to root_path
  end

end
