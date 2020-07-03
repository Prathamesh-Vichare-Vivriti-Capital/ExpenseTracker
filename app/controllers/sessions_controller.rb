class SessionsController < ApplicationController

  # skip_before_action :authorized, only: [:new, :create, :welcome]
  #
  # def new
  # end
  #
  # def create
  #   #clear the previous cookies
  #   destroy
  #   #authenticate user
  #   @user = User.find_by(email: params[:email]) || Admin.find_by(email: params[:email])
  #   if @user && @user.authenticate(params[:password])
  #     session[:user_id] = @user.id if @user.is_a?(User)
  #     session[:admin_id] = @user.id if @user.is_a?(Admin)
  #     redirect_to '/'
  #  else
  #     render :login
  #  end
  # end
  #
  # def login
  #   render json: { message: "Please login."}.to_json
  # end
  #
  # def welcome
  #   if logged_in?
  #     render json: {message: "Welcome to Expense Tracker. You are logged in, #{current_user.name}"}.to_json
  #   else
  #     render json: {message: "Welcome to Expense Tracker. Please login"}.to_json
  #   end
  # end
  #
  #
  # def destroy
  #   session.delete(:user_id) if session[:user_id]
  #   session.delete(:admin_id) if session[:admin_id]
  #   @current_user = nil
  # end

end
