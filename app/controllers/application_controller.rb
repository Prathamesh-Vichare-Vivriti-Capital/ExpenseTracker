class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :authorized
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    else
      @current_user ||= Admin.find_by(id: session[:admin_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def authorized
    redirect_to '/' unless logged_in?
  end

  def current_user?(user)
    user == current_user
  end

end
