class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  include Pundit
  before_action :authenticate_request
  attr_reader :current_user
  after_action :verify_authorized   #pundit method to check for authorize in every action

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def user_not_authorized
      #flash[:warning] = "You are not authorized to perform this action."
      render json: {"message": "You are not permitted"}.to_json, status: 400
      #redirect_to(request.referrer || '/')
    end

    def authenticate_request
      @current_user = AuthorizeApiRequest.call(request.headers).result
      render json: {error: "Not authorized"}, status: 401 unless @current_user
    end

end
