class UserController < ApplicationController
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect user_path(@user)
    else
      render root_path
    end
  end

  def show
    @user
  end
  
end
