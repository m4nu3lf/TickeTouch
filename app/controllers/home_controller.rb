class HomeController < ApplicationController

  def index
    # we need this to recognize we are in the home in the view layout
    @home = true
  end

end
