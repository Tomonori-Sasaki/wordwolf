class HomeController < ApplicationController
  def top
    flash[:notice] = nil
  end

  def rule
    flash[:notice] = 'ググれカス'
  end
end
