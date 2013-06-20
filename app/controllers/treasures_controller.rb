class TreasuresController < ApplicationController
  before_filter :treasure_box_full?, :only => [:create]

  include UsersHelper

  def index
    case current_user.type
    when 'Captain'
      render_treasure_profile_to_json(Treasure.new)
    when 'Pirate'
      treasures_purchased = render_to_string :partial => 'pirate_treasures',
                                   :locals => {:treasures => current_user.treasures.bought,
                                               :wishlist => false}

      treasures_received  = render_to_string :partial => 'pirate_treasures',
                                   :locals => {:treasures => current_user.treasures_received,
                                               :wishlist => false}


      render :json => {:t_purchased => treasures_purchased,
                       :t_received => treasures_received}
    end
  end

  def new
    case current_user.type
    when 'Captain'

      # might not be needed anymore because of AJAXing

    when 'Pirate'
      @treasure = Treasure.new

      render_local_pirate_or_captain_view 'new'
    end
  end

  def create
    if treasure_box_full?
      render :json => "ARgh! me treasure box be too full!", :status => :unprocessable_entity
    else
      add_specific_attributes_to_params_based_on_current_user_type

      treasure = Treasure.new(params[:treasure])
      current_user.treasures << treasure

      if treasure.save
        treasure_board = render_to_string :partial => 'captain_treasure_board',
                                        :locals => {:treasure_board => current_user.reload.treasures_on_sale}

        render :json => {:treasure_board => treasure_board, :success_creation => "Argh! Yeeh treasure s' on sale!"}
      else
        render :json => treasure.errors.full_messages, :status => :unprocessable_entity
      end
    end
  end

  def edit
    treasure = Treasure.find(params[:id])

    render_treasure_profile_to_json(treasure)
  end

  def update
    treasure = Treasure.find(params[:id])

    case current_user.type
    when 'Captain'
      if treasure.update_attributes(params[:treasure])
        treasure_board = render_to_string :partial => 'captain_treasure_board',
                                          :locals => {:treasure_board => current_user.treasures_on_sale}

        new_treasure_form    = render_to_string :partial => 'form_treasures',
                                                :locals => {:treasure => Treasure.new}

        success_message = 'Argh! Yeh treasure changed!'

        render :json => {:treasure_board => treasure_board,
                          :new_treasure_form => new_treasure_form,
                          :success_message => success_message}
      else
        render :json => treasure.errors.full_messages, :status => :unprocessable_entity
      end
    when 'Pirate'
      if current_user.reload.coins >= treasure.total_price
        current_user.coins -= treasure.total_price
        current_user.update_attribute(:coins, current_user.coins)
        treasure.bought!
        treasure.save

        current_user.treasures << treasure
        treasures_purchased = render_to_string :partial => 'pirate_treasures',
                                     :locals => {:treasures => current_user.treasures.bought,
                                                 :wishlist => false}

        treasures_received  = render_to_string :partial => 'pirate_treasures',
                                     :locals => {:treasures => current_user.treasures_received,
                                                 :wishlist => false}

        success_message = "You've bought the treasure!"

        render :json => {:t_purchased => treasures_purchased,
                         :t_received => treasures_received,
                         :success_message => success_message,
                         :user_coins => current_user.coins}

      else
        render :json => 'You need more doubloons!', :status => :unprocessable_entity
      end
    end
  end

  def destroy
    Treasure.find(params[:id]).destroy
    redirect_to captain_path(current_user)
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
    current_user.treasures_on_sale.length >= 6
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

