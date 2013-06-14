class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    if @user.save
      render :json => user_path(@user).to_json, :status => :created
    else
      @user.errors.delete(:password_digest)
      errors = render_to_string(:partial => 'shared/signup_errors', :locals => {:user => @user})
      render :json => errors, :status => :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

end
