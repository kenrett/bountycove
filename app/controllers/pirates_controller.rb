class PiratesController < ApplicationController
  before_filter :find_captain
  before_filter :tasks_assigned_count?, :only => [:adds]

  include UsersHelper
  include TasksHelper

  def new
    sign_up_form = render_to_string :partial => 'pirates/new_acct',
                          :locals => {:captain => current_user,
                                      :pirate => Pirate.new}

    render :json => {:sign_up_form => sign_up_form}
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
    @treasures = @pirate.treasures
    @tasks = @pirate.tasks
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
      current_user.tasks << task
      render :json => {:assign => "You just got assigned the task!" }
    else
      render :json => {:assign => "You can only have #{max_tasks} tasks at a time!" }
    end
  end

  def completes
    task = Task.find(params[:task_id])
    if task.need_verify!
      render :json => { :completed => "Nice Work you Finished the Task!"}
    else
      render :json => { :errors => 'ArgH! Something went wrong'}
    end
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
