class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    if @user.save
      render :json => user_path(@user).to_json
    else
      render :json => errors, :status => :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

end
