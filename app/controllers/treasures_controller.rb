class TreasuresController < ApplicationController
  before_filter :treasure_box_full?, :only => [:create]

  include UsersHelper

  def index
    case current_user.type
    when 'Captain'
      @treasures = current_user_treasures(Treasure::ON_SALE)  
    when 'Pirate'
      @treasures_bought   = current_user_treasures(Treasure::BOUGHT)
      @treasures_wishlist = current_user_treasures(Treasure::WISHLIST)

      @treasures_on_sale  = current_user.captain.treasures.where(status: Treasure::ON_SALE)

    end

    render_local_pirate_or_captain_view 'index'
  end

  def new
    @treasure = Treasure.new

    render_local_pirate_or_captain_view 'new'
  end

  def create
    return flash[:error] = ["ARgh! me treasure box be too full!"] if treasure_box_full?

    case current_user.type
    when 'Captain'
      params[:treasure][:tax] = tax_of(params[:treasure][:price])  
    when 'Pirate'
      params[:treasure][:status] = Treasure::WISHLIST  
    end

    treasure = Treasure.new(params[:treasure])

    if treasure.save
      current_user.treasures << treasure
      flash[:success_treasure] = 'Argh! Ye treasure was made!'
    else
      flash[:error] = treasure.errors.full_messages
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

  def tax_of(price)
    ( (current_user.tax_rate/100.0) * price.to_f ).round
  end

  def treasure_box_full?
    case current_user.type
    when 'Captain'
      current_user_treasures(Treasure::WISHLIST).length >= 6  
    when 'Pirate'
      current_user_treasures(Treasure::ON_SALE).length >= 6
    end

  end

  def redirect_to_captain_or_pirate_path
    redirect_to captain_treasures_path(current_user) if current_user_is_captain
    redirect_to pirate_treasures_path(current_user) if current_user_is_pirate
  end
end

