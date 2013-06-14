class TreasuresController < ApplicationController
  before_filter :check_limit, :only => [:create]

  def new
    @treasure = Treasure.new
  end

  def create
    @treasure = Treasure.create(params[:treasure])
    render :new
  end

  private

  def check_limit
    @treasure = Treasure.find_all_by_parent_id(params[:captain_id])
    if @treasure && @treasure.count < 6
      true
    else
      flash[:error_add_treasure] = @treasure.errors.full_messages
      render 'treasures/new'
    end
  end

end
