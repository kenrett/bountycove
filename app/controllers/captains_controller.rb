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
      task.pirate.coins += task.worth
      task.pirate.save
      
      tasks_on_board = render_to_string partial: 'tasks/captain_task_board', 
      locals: { tasks_available: current_user.tasks_on_board, 
      tasks_assigned: current_user.tasks_assigned,
      tasks_completed: current_user.tasks_completed.limit(5) }
    
      tasks_need_verify = render_task_view_to_string({
      tasks: current_user.tasks_need_verify, 
      button: true, 
      assigned: false})

      new_task_form = render_to_string partial: 'tasks/form', 
      locals: {captain: current_user, task: Task.new}

      render :json => { :tasks_on_board => tasks_on_board,
                        :task_form => new_task_form,
                        :tasks_need_verify => tasks_need_verify}
    end

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

  def render_task_view_to_string(args)
    render_to_string partial: 'tasks/captain_tasks', locals: {
     tasks:    args[:tasks], 
     button:   args[:button], 
     assigned: args[:assigned]}
   end
end
