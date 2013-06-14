class CaptainsController < ApplicationController

  def create
    @captain = Captain.new(params[:captain])
    if @captain.save
      render :json => captain_path(@captain), :status => :created
    else
      @captain.errors.delete(:password_digest)
      errors = render_to_string(:partial => 'shared/signup_errors', :locals => {:captain => @captain})
      render :json => errors, :status => :unprocessable_entity
    end
  end

  def show
    @captain = Captain.find_by_username(params[:id])
  end

end
