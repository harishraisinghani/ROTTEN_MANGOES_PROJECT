class Admin::UsersController < ApplicationController

  before_action do
    if current_user.id != 1
      flash[:notice] = "Invalid link"
      redirect_to '/'
    end
  end

  def index
    # @user = User.all
    @users = User.order(:firstname).page(params[:page]).per(2)
  end

  def show
    @user = User.find(params[:id])
  end
end
