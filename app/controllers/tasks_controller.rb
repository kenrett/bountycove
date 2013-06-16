class TasksController < ApplicationController
  before_filter :get_captain
  before_filter :get_task, :except => [:index, :new, :create]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params[:task])
      @captain
    if @task.save
      redirect_to captain_tasks_path(@captain)
    else
      flash[:errors] = @task.errors.full_messages
      redirect_to new_captain_task_path(@captain)
    end
  end

  def show
  end

  def edit
    @task = Task.find(params[:id])
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

  def get_task
    @task = Task.find(params[:id])
  end

end
