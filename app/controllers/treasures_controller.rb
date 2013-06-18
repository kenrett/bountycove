class TreasuresController < ApplicationController
  before_filter :treasure_box_full?, :only => [:create]

  include UsersHelper

  def index
    case current_user.type
    when 'Captain'
      render_treasure_profile_to_json(Treasure.new)
    when 'Pirate'
      @treasures_bought    = current_user_treasures(Treasure::BOUGHT)
      @treasures_wishlist  = current_user_treasures(Treasure::WISHLIST)
      @treasures_delivered = current_user_treasures(Treasure::DELIVERED)

      captain_treasures   = current_user.captain.treasures
      @treasures_on_sale  = captain_treasures.where(status: Treasure::ON_SALE)
      render_local_pirate_or_captain_view 'index'
    end
  end

  def show
    case current_user.type
    when 'Captain'
      treasure = Treasure.find(params[:id])
      render_treasure_profile_to_json(treasure)
    when 'Pirate'
      # treasures#show pirate
      debugger
    end
  end

  def new
    case current_user.type
    when 'Captain'
      
      # might not be needed anymore because of AJAXing
      debugger
      
    when 'Pirate'
      @treasure = Treasure.new

      render_local_pirate_or_captain_view 'new'
    end
  end

  def create
    if treasure_box_full?
      render :json => {:error => "ARgh! me treasure box be too full!"}
    else
      add_specific_attributes_to_params_based_on_current_user_type

      treasure = Treasure.new(params[:treasure])
      treasure.captain = current_user
      if treasure.save
        render :json => {:treasure => treasure}
      else
        redirect_to root_path
      end
    end
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
      current_user.treasures_on_sale.length >= 6
    when 'Pirate'
      current_user.treausers_on_wishlist.length >= 6
    end

  end

  def redirect_to_captain_or_pirate_path
    redirect_to captain_treasures_path(current_user) if current_user_is_captain
    redirect_to pirate_treasures_path(current_user) if current_user_is_pirate
  end

  def render_treasure_profile_to_json(treasure)
      treasures_to_deliver = render_treasure_view_to_string({
                                  treasures: current_user.treasures_to_deliver,
                                  on_sale: false,
                                  bought: true})

      treasures_delivered  = render_treasure_view_to_string({
                                  treasures: current_user.treasures_delivered,
                                  on_sale: false,
                                  bought: false})

      new_treasure_form    = render_to_string :partial => 'form_treasures',
                                  :locals => {:treasure => treasure}

      render :json => {:treasures_bought => treasures_to_deliver,
                       :treasures_delivered => treasures_delivered,
                       :new_treasure_form => new_treasure_form,
                       :tax_rate => current_user.tax_rate,
                       :captain => current_user.name}
  end

  def render_treasure_view_to_string(args)
    render_to_string :partial => 'captain_treasures',
                                    :locals => {:treasures => args[:treasures],
                                                :on_sale => args[:on_sale],
                                                :bought => args[:bought]}
  end
end

