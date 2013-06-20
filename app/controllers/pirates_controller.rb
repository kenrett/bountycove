class PiratesController < ApplicationController
  before_filter :find_captain
  before_filter :tasks_assigned_count?, :only => [:adds]

  include UsersHelper
  include TasksHelper

  def index
    sign_up_form = render_to_string :partial => 'new_acct_form',
                                    :locals => {:captain => current_user,
                                                :pirate => Pirate.new}

    list_pirates = render_to_string :partial => 'captains/list_of_pirates',
                                    :locals => {:pirates => current_user.pirates}

    render :json => {:sign_up_form => sign_up_form,
                     :list_of_pirates => list_pirates}
  end

  def edit
    pirate = Pirate.find_by_username(params[:id])
    pirate_edit_form = render_to_string :partial => 'pirates/new_acct_form',
                                        :locals => {:captain => current_user,
                                                    :pirate => pirate}

    render :json => {:pirate_edit_form => pirate_edit_form}
  end

  def new
    sign_up_form = render_to_string :partial => 'pirates/new_acct_form',
                                    :locals => {:captain => current_user,
                                                :pirate => Pirate.new}

    render :json => {:sign_up_form => sign_up_form}
  end

  def update
    pirate = Pirate.find_by_username(params[:id])

    if pirate.update_attributes(params[:pirate])
      sign_up_form = render_to_string :partial => 'new_acct_form',
                                      :locals => {:captain => current_user,
                                                  :pirate => Pirate.new}

      list_pirates = render_to_string :partial => 'captains/list_of_pirates',
                                      :locals => {:pirates => current_user.pirates}

      success_message = 'Argh! Your pirate got a new eyepatch!'

      render :json => {:sign_up_form => sign_up_form,
                       :list_of_pirates => list_pirates,
                       :success_message => success_message}
    else
      render :json => pirate.errors.full_messages, :status => :unprocessable_entity
    end
  end

  def create
    pirate = Pirate.new(params[:pirate])
    pirate.tax_rate = nil
    pirate.captain  = current_user

    if pirate.save
      success_message = "Arggh! A new pirate on deck!"

      sign_up_form = render_to_string :partial => 'new_acct_form',
                                      :locals => {:captain => current_user,
                                                  :pirate => Pirate.new}

      list_pirates = render_to_string :partial => 'captains/list_of_pirates',
                                      :locals => {:pirates => current_user.pirates}

      render :json => {:sign_up_form => sign_up_form,
                       :list_of_pirates => list_pirates,
                       :success_message => success_message}
    else
      pirate.errors.delete(:password_digest)
      render :json => pirate.errors.full_messages, :status => :unprocessable_entity
    end
  end

  def show
    @pirate = Pirate.find_by_username(params[:id])
    @treasures = @pirate.treasures_purchaseable
    @tasks = @pirate.tasks.on_board
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
