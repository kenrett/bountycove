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
                       accept_button: true, 
                       complete_button: false})

      tasks_assigned = render_task_view_to_string({
                       tasks: current_user.tasks_assigned , 
                       accept_button: false , 
                       complete_button: true })

      tasks_need_verify = render_task_view_to_string({
                       tasks: current_user.tasks_need_verify , 
                       accept_button: false , 
                       complete_button: false})
        
      tasks_completed = render_task_view_to_string({
                       tasks: current_user.tasks_completed , 
                       accept_button:false , 
                       complete_button:false })
      
      render :json => {:tasks_on_board => tasks_on_board,
                       :tasks_assigned => tasks_assigned,
                       :tasks_need_verify => tasks_need_verify,
                       :tasks_completed => tasks_completed }
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
      flash[:errors] = ["Only 6 available tasks allowed!"]
      redirect_to captain_tasks_path(current_user)
    else
      @task = Task.new
      form = render_to_string :partial => 'form', :locals => {captain: @captain, task: @task}
      render :json => {:form => form}
    end
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      @captain.tasks << @task
      redirect_to captain_tasks_path(@captain)
    else
      flash[:errors] = @task.errors.full_messages
      redirect_to new_captain_task_path(@captain)
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
    render_to_string :partial => "pirate_tasks", :locals => {
                     :tasks           => args[:tasks], 
                     :accept_button   => args[:accept_button], 
                     :complete_button => args[:complete_button]}
  end

end
