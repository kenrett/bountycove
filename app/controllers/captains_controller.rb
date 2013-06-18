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

    redirect_to captain_tasks_path(current_user)
  end

  def delivers_treasure
    treasure = Treasure.find(params[:treasure_id])

    treasure.status = Treasure::DELIVERED
    treasure.save

    redirect_to captain_treasures_path(current_user)
  end
end
