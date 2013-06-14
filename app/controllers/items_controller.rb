class ItemsController < ApplicationController
  before_filter :check_limit, :only => [:create]

  def new
    @item = Item.new
    render :new
  end

  def create
    @item = Item.create(params[:item])
    render :new
  end

  private

  def check_limit
    @loot = Item.find_all_by_parent_id(params[:parent_id])
    if @loot && @loot.count < 6
      true
    else
      render 'items/new', :notice => "The Treasure Chest is Full! Limit 6 items"
    end
  end

end
