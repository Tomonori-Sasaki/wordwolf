class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    binding.pry

    @user = User.new(image: params[:image])
    @user.save
    flash[:notice] = '新たなデュエリストが登録されました'
    redirect_to(users_path)
  end

  def setting
  end

  def show
  end


end
