class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    
    if @user.save
      session[:user_id] = @user.id
      render :show
    else
      p flash[:errors_signup] = @user.errors.full_messages
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])

    if @user && session[:user_id] == @user.id
      user_path(@user)
    else
      redirect_to root_path
    end
  end

end
