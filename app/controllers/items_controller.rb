class ItemsController < ApplicationController
  
  def new
     @item = Item.new
     render :new
  end

end
