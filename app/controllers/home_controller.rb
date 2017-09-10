class HomeController < ApplicationController
  def top
  end

  def rule
    flash[:notice] = 'ググれカス'
  end
end
