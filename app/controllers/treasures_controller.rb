class TreasuresController < ApplicationController
  before_filter :treasure_box_full?, :only => [:create]

  include UsersHelper

  def index
    case current_user.type
    when 'Captain'
      @treasures_on_sale   = current_user_treasures(Treasure::ON_SALE)
      @treasures_bought    = current_user_treasures(Treasure::BOUGHT)
      @treasures_delivered = current_user_treasures(Treasure::DELIVERED)    
    
      treasures_on_sale   = render_treasure_view_to_string({
                                        treasures: @treasures_on_sale,
                                        on_sale: true,
                                        bought: false})

      treasures_bought    = render_treasure_view_to_string({
                                        treasures: @treasures_bought,
                                        on_sale: true,
                                        bought: false})

      treasures_delivered = render_treasure_view_to_string({
                                        treasures: @treasures_delivered,
                                        on_sale: false,
                                        bought: false})

      render :json => {:treasures_on_sale => treasures_on_sale ,
                       :treasures_bought => treasures_bought,
                       :treasures_delivered => treasures_delivered}
    when 'Pirate'
      @treasures_bought    = current_user_treasures(Treasure::BOUGHT)
      @treasures_wishlist  = current_user_treasures(Treasure::WISHLIST)
      @treasures_delivered = current_user_treasures(Treasure::DELIVERED)

      captain_treasures   = current_user.captain.treasures
      @treasures_on_sale  = captain_treasures.where(status: Treasure::ON_SALE)
    end

    # render_local_pirate_or_captain_view 'index'
  end

  def new
    @treasure = Treasure.new

    render_local_pirate_or_captain_view 'new'
  end

  def create
    if treasure_box_full?
      flash[:error] = ["ARgh! me treasure box be too full!"]
      return redirect_to_captain_or_pirate_path
    end

    add_specific_attributes_to_params_based_on_current_user_type

    treasure = Treasure.new(params[:treasure])

    if treasure.save
      current_user.treasures << treasure
      flash[:success_treasure_created] = 'Argh! Ye treasure was made!'
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

  def add_specific_attributes_to_params_based_on_current_user_type
    case current_user.type
    when 'Captain'
      params[:treasure][:tax] = tax_of(params[:treasure][:price])  
    when 'Pirate'
      params[:treasure][:status] = Treasure::WISHLIST  
    end
  end

  def treasure_box_full?
    case current_user.type
    when 'Captain'
      current_user_treasures(Treasure::ON_SALE).length >= 6
    when 'Pirate'
      current_user_treasures(Treasure::WISHLIST).length >= 6
    end

  end

  def redirect_to_captain_or_pirate_path
    redirect_to captain_treasures_path(current_user) if current_user_is_captain
    redirect_to pirate_treasures_path(current_user) if current_user_is_pirate
  end

  def render_treasure_view_to_string(args)
    render_to_string :partial => 'captain_treasures',
                                    :locals => {:treasures => args[:treasures],
                                                :on_sale => args[:on_sale],
                                                :bought => args[:bought]}
  end
end

