class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def restrict_access
    if !current_user
      flash[:alert] = "You must first log in"
      redirect_to new_session_path
    end
  end

  helper_method :current_user
end
