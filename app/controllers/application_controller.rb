class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  include Error::ErrorHandler
  include Pundit
  before_action :authenticate_request
  attr_reader :current_user
  after_action :verify_authorized   #pundit method to check for authorize in every action

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def user_not_authorized
      render json: {"message": "You are not permitted"}.to_json, status: 401
    end

    def authenticate_request
      @current_user = AuthorizeApiRequest.call(request.headers).result
      render json: {error: "Not authorized"}, status: 401 unless @current_user
    end

end
