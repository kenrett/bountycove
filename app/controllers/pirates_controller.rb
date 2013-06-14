class PiratesController < ApplicationController

  def create
    @pirate = Pirate.new(params[:captain])
    if @pirate.save
      render :json => pirate_path(@pirate), :status => :created
    else
      @pirate.errors.delete(:password_digest)
      errors = render_to_string(:partial => 'shared/signup_errors', :locals => {:pirate => @pirate})
      render :json => errors, :status => :unprocessable_entity
    end
  end

  def show
    @pirate = Pirate.find_by_username(params[:id])
  end

end
