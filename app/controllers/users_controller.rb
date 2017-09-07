class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if params[:num].to_i >= 3
     redirect_to("/users/player/#{params[:num]}")
    else
      flash[:notice] = "お前#{params[:num]}人しか友達いないんか！？"
      render("users/new")
    end
  end

  def player
    @num = params[:num]
  end


end
