class UsersController < ApplicationController
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to user_path(@user)
    else
      render root_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

end
