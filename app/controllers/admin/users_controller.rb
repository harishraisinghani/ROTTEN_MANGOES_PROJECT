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

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "#{@user.firstname} successfully created!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path, notice: "#{@user.firstname} successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    UserMailer.goodbye_email(@user).deliver_later
    redirect_to admin_users_path
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
end
