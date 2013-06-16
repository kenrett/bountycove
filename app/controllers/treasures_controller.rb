class TreasuresController < ApplicationController
  before_filter :treasure_full?, :only => [:create]

  include UsersHelper

  def index
    if current_user.type == 'Captain'
      @treasures = current_user.treasures
    else
      @treasures = current_user.captain.treasures
    end
  end

  def new
    @treasure = Treasure.new
    render :new
  end

  def create
    if treasure_full?
      current_user.treasures << Treasure.create(params[:treasure])
      redirect_to captain_treasures_path(current_user)
    else
      flash[:errors_treasure] = ["ARgh! Me treasure box be too full!"]
      redirect_to captain_treasures_path(current_user)
    end
  end

  def edit
    @treasure = Treasure.find(params[:id])
  end

  def update
    Treasure.find(params[:id]).update_attributes(params[:treasure])
    redirect_to captain_treasures_path(current_user)
  end

  def destroy
    Treasure.find(params[:id]).destroy
    redirect_to captain_treasures_path(current_user)
  end

  private

  def treasure_full?
    current_user.treasures.length < 6
  end
end

