class CaptainsController < ApplicationController

  def create
    @captain = Captain.new(params[:captain])
    if @captain.save
      session[:user_id] = @captain.id
      redirect_to captain_path(@captain.username)
    else
      @captain.errors.delete(:password_digest)
      flash[:errors_signup] = @captain.errors.full_messages
      redirect_to root_path
    end
  end

  def show
    @captain = Captain.find_by_username(params[:id])
  end
end
