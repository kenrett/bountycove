class TasksController < ApplicationController
  before_filter :get_captain
  before_filter :get_task, :except => [:index, :new, :create]

  include UsersHelper
  include TasksHelper

  def index
    case current_user.type
    when 'Captain'
      tasks_on_board = render_task_view_to_string({
        tasks: current_user.tasks_on_board, 
        button: false, 
        assigned: false})

      tasks_assigned = render_task_view_to_string({
        tasks: current_user.tasks_assigned , 
        button: false , 
        assigned: true })

      tasks_need_verify = render_task_view_to_string({
        tasks: current_user.tasks_need_verify , 
        button: true , 
        assigned: false})
        
      tasks_completed = render_task_view_to_string({
        tasks: current_user.tasks_completed.order('updated_at ASC').limit(5) , 
        button: false , 
        assigned: true })

      new_task_form = render_to_string :partial => 'task_form', :locals => {captain: @captain, task: Task.new}
      
      render :json => {:tasks_on_board => tasks_on_board,
                       :tasks_assigned => tasks_assigned,
                       :tasks_need_verify => tasks_need_verify,
                       :tasks_completed => tasks_completed,
                       :task_form => new_task_form }

    when 'Pirate'
      @tasks = current_user.captain.tasks
      
      @tasks_on_board    = @tasks.where(status: Task::ON_BOARD)
      @tasks_assigned    = @tasks.where(status: Task::ASSIGNED)
      @tasks_need_verify = @tasks.where(status: Task::NEED_VERIFY)
      @tasks_completed   = @tasks.where(status: Task::COMPLETED)

      render_local_pirate_or_captain_view 'index'
    end
  end

  def new
    if count_of_available_tasks >= 6
      # needed anymore?
      # render :json => { error: "Only 6 available tasks allowed!"}
    else
      redirect_to root_path
    end
  end

  def create
    @task = Task.new(params[:task])
    if count_of_available_tasks >= 6
      render :json => { :error => "Only 6 available tasks allowed!" }
    elsif @task.save
      @captain.tasks << @task
      redirect_to captain_path(@captain)
    end
  end

  def show
    @task = Task.find(params[:id])

    render_local_pirate_or_captain_view 'show'
  end

  def edit
    @task = Task.find(params[:id])

    render_local_pirate_or_captain_view 'edit'
  end

  def update
    @task.update_attributes params[:task]
    redirect_to captain_tasks_path(@captain)
  end

  def destroy
    @task.destroy
    redirect_to captain_tasks_path(@captain)
  end

  private

  def get_captain
    @captain = Captain.find_by_username(params[:captain_id])
  end

  def get_pirate
    @pirate = Pirate.find_by_username(params[:pirate_id])
  end

  def get_task
    @task = Task.find(params[:id])
  end

  def render_task_view_to_string(args)
    render_to_string :partial => "captain_tasks", :locals => {
                     :tasks    => args[:tasks], 
                     :button   => args[:button], 
                     :assigned => args[:assigned]}
  end

end
