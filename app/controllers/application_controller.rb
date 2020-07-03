class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  include Pundit
  before_action :authenticate_request
  attr_reader :current_user

  # before_action :authorized
  # helper_method :current_user
  # helper_method :logged_in?
  #
  # def current_user
  #   if session[:user_id]
  #     @current_user ||= User.find_by(id: session[:user_id])
  #   else
  #     @current_user ||= Admin.find_by(id: session[:admin_id])
  #   end
  # end
  #
  # def logged_in?
  #   !current_user.nil?
  # end
  #
  # def authorized
  #   redirect_to '/' unless logged_in?
  # end
  #
  # def current_user?(user)
  #   user == current_user
  # end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def user_not_authorized
      #flash[:warning] = "You are not authorized to perform this action."
      render json: {"message": "You are not permitted"}.to_json
      #redirect_to(request.referrer || '/')
    end

    def authenticate_request
      @current_user = AuthorizeApiRequest.call(request.headers).result
      render json: {error: "Not authorized"}, status: 401 unless @current_user
    end

end
