class CaptainsController < ApplicationController

  include UsersHelper

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
    @captain = Captain.find_by_username(params[:id])
  end

  def confirm
    task = Task.find(params[:task_id])
    if task.completed!
      flash[:task_completed] = "Nice Work you Finished the Task!"
      task.pirate.update_attribute('coins',(task.pirate.coins + task.worth))
    else
      flash[:error_adding] = 'ArgH! Something went wrong'
    end

    redirect_to captain_tasks_path(current_user)
  end
end
