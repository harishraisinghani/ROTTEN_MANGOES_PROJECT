class Admin::UsersController < ApplicationController

  before_action do
    if current_user.id != 1
      flash[:notice] = "Invalid link"
      redirect_to '/'
    end
  end

  def index
  end
end
