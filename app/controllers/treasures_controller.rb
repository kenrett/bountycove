class TreasuresController < ApplicationController
  before_filter :check_limit, :only => [:create]

  include UsersHelper

  def index
    @treasures = Treasure.find_all_by_captain_id(params[:captain_id])
  end

  def new
    @treasure = Treasure.new
    render :new
  end

  def create
    current_user.treasures << Treasure.create(params[:treasure])
    render :new
  end

  private

  def check_limit
    captain = Captain.find(params[:captain_id])
    treasure = Treasure.find_all_by_captain_id(captain.id)
    if treasure && treasure.count < 6
      true
    else
      flash[:errors_treasure] = ["ARgh! Me treasure box be too full!"]
      render 'treasures/new'
    end
  end
end

