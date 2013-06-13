class UserController < ApplicationController
  
  def create
    @user = User.new(params[:user])

    if @user.save
      redirect new_user_path
    else
      render root_path
    end

  end

end
