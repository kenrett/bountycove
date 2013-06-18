class PiratesController < ApplicationController
  before_filter :find_captain, :tasks_assigned_count?, :only => [:adds]

  include UsersHelper
  include TasksHelper

  def new
    @pirate = Pirate.new
  end

  def create
    @pirate = Pirate.new(params[:pirate])
    @pirate.tax_rate = nil

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

  def buys_treasure
    treasure = Treasure.find(params[:treasure_id])

    if purchaseable?(treasure)
      current_user.coins -= treasure.total_price

      current_user.save
      current_user.treasures << treasure
      treasure.bought!

      flash[:treasure_bought] = 'You bought that treasure!'
    else
      flash[:error_deficit_gold] = 'Argh! You need more gold to purchase!'
    end

    redirect_to pirate_treasures_path(current_user)
  end

  def adds
    task = Task.find(params[:task_id])
    max_tasks = 3
    if tasks_assigned_count? < max_tasks
      task.assigned!
      flash[:task_assigned] = "You just got assigned the task!"
      current_user.tasks << task
    else
      flash[:errors] = ["You can only have #{max_tasks} tasks at a time"]
    end

    redirect_to pirate_tasks_path(current_user)
  end

  def completes
    task = Task.find(params[:task_id])
    if task.need_verify!
      flash[:task_sent_for_verify] = "Nice Work you Finished the Task!"
    else
      flash[:error_adding] = 'ArgH! Something went wrong'
    end

    redirect_to pirate_tasks_path(current_user)
  end

  private

  def purchaseable?(treasure)
    current_user.coins >= treasure.total_price
  end

  def find_captain
    @captain = Captain.find_by_username(params[:captain_id])
  end

  def tasks_assigned_count?
    current_user_tasks_assigned(Task::ASSIGNED).length
  end
end
