class TreasuresController < ApplicationController
  before_filter :treasure_box_full?, :only => [:create]

  include UsersHelper

  def index
    @treasures = current_user.treasures if current_user_is_captain
    @treasures = current_user.captain.treasures if current_user_is_pirate

    render_local_pirate_or_captain_view 'index'
  end

  def new
    @treasure = Treasure.new
  end

  def create
    unless treasure_box_full?
      current_user.treasures << Treasure.create(params[:treasure])
    else
      flash[:errors_treasure] = ["ARgh! Me treasure box be too full!"]
    end

    redirect_to_captain_or_pirate_path
  end

  def edit
    @treasure = Treasure.find(params[:id])

    render_local_pirate_or_captain_view 'edit'
  end

  def update
    Treasure.find(params[:id]).update_attributes(params[:treasure])
    redirect_to_captain_or_pirate_path
  end

  def destroy
    Treasure.find(params[:id]).destroy
    redirect_to_captain_or_pirate_path
  end

  private

  def treasure_box_full?
    current_user.treasures.length > 6
  end

  def redirect_to_captain_or_pirate_path
    if current_user_is_captain
        redirect_to captain_treasures_path(current_user)
      else
        redirect_to pirate_treasures_path(current_user)
    end
  end
end

