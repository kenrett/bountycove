class TasksController < ApplicationController
  before_filter :get_captain
  before_filter :get_task, :except => [:index, :new, :create]

  include UsersHelper
  include TasksHelper

  def index
    if current_user_is_captain 
      @tasks = current_user.tasks 
    else
      @tasks = current_user.captain.tasks
    end

    @tasks_on_board    = @tasks.where(status: Task::ON_BOARD)
    @tasks_assigned    = @tasks.where(status: Task::ASSIGNED)
    @tasks_need_verify = @tasks.where(status: Task::NEED_VERIFY)
    @tasks_completed   = @tasks.where(status: Task::COMPLETED)

    render_local_pirate_or_captain_view 'index'
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

end
