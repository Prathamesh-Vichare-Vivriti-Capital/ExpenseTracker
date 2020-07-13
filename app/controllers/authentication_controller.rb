class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request
  skip_after_action :verify_authorized, only: [:authenticate]

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: {auth_token: command.result}
    else
      raise ::Error::AuthenticationError
    end
  end
end
