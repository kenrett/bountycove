class PiratesController < ApplicationController
  before_filter :find_captain

  include UsersHelper
  def new
    @pirate = Pirate.new
  end

  def create
    @pirate = Pirate.new(params[:pirate])
    if @pirate.save
      @captain.pirates << @pirate
      redirect_to captain_path(@captain)
    else
      @pirate.errors.delete(:password_digest)
      flash[:errors_signup] = @pirate.errors.full_messages
      render 'pirates/new'
    end
  end

  def show
    @pirate = Pirate.find_by_username(params[:id])
  end

  def buys
    treasure = Treasure.find(params[:treasure_id])
    if treasure.bought!
      current_user.treasures << treasure
      redirect_to pirate_treasures_path(current_user)
    else
      flash[:errors_buying] = 'Argh! Something went wrong with buying!'
      redirect_to pirate_treasures_path(current_user)
    end
  end

  private

  def find_captain
    @captain = Captain.find_by_username(params[:captain_id])
  end

end
