class CaptainsController < ApplicationController

  include UsersHelper
  include TasksHelper

  def create
    @captain = Captain.new(params[:captain])
    if @captain.save
      session[:user_id] = @captain.username
      redirect_to captain_path(@captain)
    else
      @captain.errors.delete(:password_digest)
      flash[:errors_signup] = @captain.errors.full_messages
      redirect_to root_path
    end
  end

  def show
    @treasures = current_user.treasures.on_sale
    @pirates = current_user.pirates
    @tasks = current_user.tasks
    @tasks = @tasks.pop(5) if @tasks.size > 5
  end

  def confirm
    task = Task.find(params[:task_id])
    if task.completed!
      flash[:task_completed] = "Nice Work you Finished the Task!"
      task.pirate.coins += task.worth
      task.pirate.save
    else
      flash[:error_adding] = 'ArgH! Something went wrong'
    end

    redirect_to captain_path(current_user)
  end

  def delivers_treasure
    treasure = Treasure.find(params[:treasure_id])

    treasure.status = Treasure::DELIVERED
    treasure.save

    treasures_to_deliver = render_treasure_view_to_string({
                                  treasures: current_user.treasures_to_deliver,
                                  on_sale: false,
                                  bought: true})

    treasures_delivered  = render_treasure_view_to_string({
                                  treasures: current_user.treasures_delivered,
                                  on_sale: false,
                                  bought: false})

    render :json => {:treasures_to_deliver => treasures_to_deliver,
                       :treasures_delivered => treasures_delivered,
                       :tax_rate => current_user.tax_rate,
                       :success_message => "Argh! Yeah treasure was delivered!"}
  end

  def render_treasure_view_to_string(args)
    render_to_string :partial => 'treasures/captain_treasures',
                                    :locals => {:treasures => args[:treasures],
                                                :on_sale => args[:on_sale],
                                                :bought => args[:bought]}
  end
end
