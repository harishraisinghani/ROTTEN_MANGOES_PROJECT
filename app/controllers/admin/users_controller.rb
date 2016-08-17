class Admin::UsersController < ApplicationController

  before_action do
    unless current_user && current_user.admin
      flash[:notice] = "Invalid link"
      redirect_to '/'
    end
  end

  def index
    @users = User.order(:firstname).page(params[:page]).per(2)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end
end
