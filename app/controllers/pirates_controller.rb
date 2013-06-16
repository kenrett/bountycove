class PiratesController < ApplicationController
  before_filter :find_captain

  include UsersHelper

  def new
    @pirate = Pirate.new
  end

  def create
    @pirate = Pirate.new(params[:pirate])
    if @pirate.save
      @captain.pirates << @pirate
      redirect_to captain_path(@captain)
    else
      @pirate.errors.delete(:password_digest)
      flash[:errors_signup] = @pirate.errors.full_messages
      render :new
    end
  end

  def show
    @pirate = Pirate.find_by_username(params[:id])
  end

  def buys
    treasure = Treasure.find(params[:treasure_id])
    if treasure.bought!
      flash[:treasure_bought] = 'You bought that treasure!'
      current_user.treasures << treasure
    else
      flash[:errors_buying] = 'Argh! Something went wrong with buying!'
    end
    redirect_to pirate_treasures_path(current_user)
  end

  def adds
    task = Task.find(params[:task_id])
    if task.assigned!
      flash[:task_assigned] = "You just got assigned the task!"
      current_user.tasks << task
    else
      flash[:error_adding] = 'ArgH! Something went wrong'
    end

    redirect_to pirate_tasks_path(current_user)
  end

  private

  def find_captain
    @captain = Captain.find_by_username(params[:captain_id])
  end

end
