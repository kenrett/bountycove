class PiratesController < ApplicationController
  before_filter :find_captain
  before_filter :tasks_assigned_count?, :only => [:adds]

  include UsersHelper
  include TasksHelper

  def index
    sign_up_form = render_to_string :partial => 'new_acct_form',
                                    :locals => {:captain => current_user,
                                                :pirate => Pirate.new}

    list_pirates = render_to_string :partial => 'captains/list_of_pirates',
                                    :locals => {:pirates => current_user.pirates}

    render :json => {:sign_up_form => sign_up_form,
                     :list_of_pirates => list_pirates}
  end

  def edit
    pirate = Pirate.find_by_username(params[:id])
    pirate_edit_form = render_to_string :partial => 'pirates/new_acct_form',
                                        :locals => {:captain => current_user,
                                                    :pirate => pirate}

    render :json => {:pirate_edit_form => pirate_edit_form}
  end

  def new
    sign_up_form = render_to_string :partial => 'pirates/new_acct_form',
                                    :locals => {:captain => current_user,
                                                :pirate => Pirate.new}

    render :json => {:sign_up_form => sign_up_form}
  end

  def update
    pirate = Pirate.find_by_username(params[:id])

    if pirate.update_attributes(params[:pirate])
      sign_up_form = render_to_string :partial => 'new_acct_form',
                                      :locals => {:captain => current_user,
                                                  :pirate => Pirate.new}

      list_pirates = render_to_string :partial => 'captains/list_of_pirates',
                                      :locals => {:pirates => current_user.pirates}

      success_message = 'Argh! Your pirate got a new eyepatch!'

      render :json => {:sign_up_form => sign_up_form,
                       :list_of_pirates => list_pirates,
                       :success_message => success_message}
    else
      render :json => pirate.errors.full_messages, :status => :unprocessable_entity
    end
  end

  def create
    if current_user.pirates.count < Pirate::MAX
      pirate = Pirate.new(params[:pirate])
      pirate.tax_rate = 5
      pirate.captain  = current_user

      if pirate.save
        success_message = "Arggh! A new pirate on deck!"

        sign_up_form = render_to_string :partial => 'new_acct_form',
                                        :locals => {:captain => current_user,
                                                    :pirate => Pirate.new}

        list_pirates = render_to_string :partial => 'captains/list_of_pirates',
                                        :locals => {:pirates => current_user.pirates}

        render :json => {:sign_up_form => sign_up_form,
                         :list_of_pirates => list_pirates,
                         :success_message => success_message}
      else
        pirate.errors.delete(:password_digest)
        render :json => pirate.errors.full_messages, :status => :unprocessable_entity
      end
    else
      render :json => ['Your ship is overcrowded with pirates!'].to_json, :status => :unprocessable_entity
    end
  end

  def show
    @pirate = Pirate.find_by_username(params[:id])
    @treasures = @pirate.treasures_purchaseable
    @treasures_bought = @pirate.treasures.bought
    @tasks = @pirate.captain.tasks.on_board
  end

  def adds
    task = Task.find(params[:task_id])
    max_tasks = 4
    if tasks_assigned_count? < max_tasks
      task.assigned!
      current_user.tasks << task
      reload_page
    else
      render :json => "You can only have #{max_tasks} tasks at a time!"
    end
  end

  def completes
    task = Task.find(params[:task_id])
    if task.need_verify!
      render :json => { :completed => "Nice Work you Finished the Task!"}
      reload_page
    else
      reload_page
    end
  end

  private

  def can_purchase?(treasure)
    current_user.coins >= treasure.total_price
  end

  def find_captain
    @captain = Captain.find_by_username(params[:captain_id])
  end

  def tasks_assigned_count?
    current_user_tasks_assigned(Task::ASSIGNED).length
  end

  def render_task_view_to_string(args)
    render_to_string partial: "pirate_tasks", locals: {
                             tasks:    args[:tasks],
                             button:   args[:button],
                             assigned: args[:assigned]}
  end

  def reload_page
      tasks_on_board = render_to_string partial: 'tasks/pirate_task_board',
      locals: { tasks_available: current_user.captain.tasks_on_board,
      tasks_need_verify: current_user.tasks_need_verify,
      tasks_completed: current_user.tasks_completed.limit(5) }
      
      tasks_available = render_task_view_to_string({
      tasks: current_user.captain.tasks_on_board, 
      button: false,
      assigned: true,
      user_task: "pirates/pirate_tasks"})

      tasks_assigned = render_task_view_to_string({
      tasks: current_user.tasks_assigned,
      button: false,
      assigned: true})
      
      task_highlight = render_to_string partial: 'tasks/pirate_highlight_task',
      locals: {task: current_user.tasks_assigned.first}

      render json: {
      tasks_on_board: tasks_on_board,
      tasks_assigned: tasks_assigned, 
      tasks_available: tasks_available, 
      task_highlight: task_highlight }
  end
end
