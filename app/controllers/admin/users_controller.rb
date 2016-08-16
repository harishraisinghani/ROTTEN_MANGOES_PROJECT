class Admin::UsersController < ApplicationController

  before_action do
    if current_user.id != 1
      flash[:notice] = "Sorry, you do not have admin privileges"
      redirect_to '/'
    end
  end

  def index
  end
end
