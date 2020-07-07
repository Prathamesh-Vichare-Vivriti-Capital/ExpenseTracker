class UsersController < ApplicationController
  before_action :check_auth, only: [:index, :create, :update, :destroy]

  #/admins/:admin_id/users     only admin access
  def index
    @users = current_user.users
  end

  def show
    authorize params[:id], policy_class: UserPolicy
    if current_user.is_a?(User)
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end

  #admin/:admin_id/users    (only admin)
  def create
    @user = User.new(user_params)
    @user.admin_id = current_user.id
    @user.employment_status = 'working'
    if @user.save
      render :show, :id => @user
    else
      render json: {error: "Not saved."}.to_json, status: 400
    end
  end


  def update
    @user = current_user
    if @user.update_attributes(user_params)
      render :show, :id => @user
    else
      render json: { error: "Not saved."}.to_json, status: 400
    end
  end

  def destroy
    current_user.destroy
  end

  private

    def user_params
      params.permit( :email, :password, :name)
    end

    def check_auth
      authorize current_user, policy_class: UserPolicy
    end

end
