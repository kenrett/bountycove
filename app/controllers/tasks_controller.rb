class TasksController < ApplicationController
  before_filter :get_captain
  before_filter :get_task, except: [:index, :new, :create]

  include UsersHelper
  include TasksHelper

  def index
    case current_user.type
    when 'Captain'
      render_task_profile_to_json(Task.new)
    when 'Pirate'

      tasks_on_board = render_to_string partial: 'pirate_task_board', 
      locals: { tasks_available: current_user.captain.tasks_on_board, 
      tasks_assigned: current_user.tasks_assigned,
      tasks_completed: current_user.tasks_completed.limit(5) }

      tasks_need_verify = render_task_view_to_string({
      tasks: current_user.tasks_need_verify, 
      button: true, 
      assigned: false})
      
      # task_highlight = render_to_string partial: 'pirate_highlight_task',
      # locals: {task: current_user.tasks_assigned.first}

      render json: {tasks_on_board: tasks_on_board,
      tasks_need_verify: tasks_need_verify}#, task_highlight: task_highlight }
    end

  end

  def create
    @task = Task.new(params[:task])
    if count_of_available_tasks >= 6
      render json: "Only 6 available tasks allowed!", status: :unprocessable_entity
    elsif @task.save
      @captain.tasks << @task
      render_task_profile_to_json(Task.new)
      # render json: { task_create: "A new Quest has been set!" }
    else
      render json: "All fields must be filled", status: :unprocessable_entity
    end
  end

  def show
    task = Task.find(params[:id])
  end

  def edit
    task = Task.find(params[:id])
    task_edit_form = render_to_string partial: 'form', locals: {captain: current_user, task: task}
    render json: { task_form: task_edit_form }
  end

  def update
    Task.find(params[:id]).update_attributes(params[:task])
    
    tasks_on_board = render_to_string partial: 'captain_task_board', 
    locals: { tasks_available: current_user.tasks_on_board, 
      tasks_assigned: current_user.tasks_assigned,
      tasks_completed: current_user.tasks_completed.limit(5) }
    
    tasks_need_verify = render_task_view_to_string({
    tasks: current_user.tasks_need_verify, 
    button: true, 
    assigned: false})

    new_task_form = render_to_string partial: 'form', 
      locals: {captain: @captain, task: Task.new}

    success_message = 'Argh! Yeh Task changed!'

    render :json => { :tasks_on_board => tasks_on_board,
                      :task_form => new_task_form,
                      :tasks_need_verify => tasks_need_verify,
                      :success_message => success_message}
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

  def render_task_profile_to_json(task)
    tasks_on_board = render_to_string partial: 'captain_task_board', 
    locals: { tasks_available: current_user.tasks_on_board, 
    tasks_assigned: current_user.tasks_assigned,
    tasks_completed: current_user.tasks_completed.limit(5) }

    tasks_need_verify = render_task_view_to_string({
    tasks: current_user.tasks_need_verify, 
    button: true, 
    assigned: false})

    new_task_form = render_to_string partial: 'form', 
    locals: {captain: @captain, task: Task.new}      

    render json: {tasks_on_board: tasks_on_board,
    tasks_need_verify: tasks_need_verify,
       task_form: new_task_form }
  end

   def render_task_view_to_string(args)
    render_to_string partial: "captain_tasks", locals: {
     tasks:    args[:tasks], 
     button:   args[:button], 
     assigned: args[:assigned]}
   end

end
