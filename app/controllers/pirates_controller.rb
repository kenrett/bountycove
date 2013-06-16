class PiratesController < ApplicationController
  before_filter :find_captain

  def create
    @pirate = Pirate.new(params[:captain])
    if @pirate.save
      redirect_to captain_path(@captain.username)
    else
      @pirate.errors.delete(:password_digest)
      flash[:errors_signup] = @pirate.errors.full_messages
      redirect_to root_path
    end
  end

  def show
    @pirate = Pirate.find_by_username(params[:id])
  end

  private

  def find_captain
    @captain = Captain.find_by_username(params[:captain_id])
  end

end
