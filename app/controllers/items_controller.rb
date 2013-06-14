class ItemsController < ApplicationController
  
  def new
    @item = Item.new
    render :new
  end

  def create
    @item = Item.create(params[:item])
    render :new
  end

end
