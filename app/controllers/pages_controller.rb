class PagesController < ApplicationController

  def index
    @captain = Captain.new
  end

end
