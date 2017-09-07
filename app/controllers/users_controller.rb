class UsersController < ApplicationController

  def index
  end

  def new
    @user = User.new
  end

  def create
    redirect_to(users_path)
  end

  def setting
  end


end
