class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  include Error::ErrorHandler
  include Pundit
  before_action :authenticate_request
  attr_reader :current_user
  after_action :verify_authorized   #pundit method to check for authorize in every action


  private

  def current_user
    AuthorizeApiRequest.call(request.headers).result
  end

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    raise ::Error::NotAuthorizedError unless @current_user
  end

end
