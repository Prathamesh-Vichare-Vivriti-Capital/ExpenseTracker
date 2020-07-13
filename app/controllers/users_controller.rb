class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update, :destroy, :employment_status_update]
  before_action :set_admin, only: [ :index, :create]


  #/admins/:admin_id/users  (only admin)
  def index
    @users = @admin.users
  end

  def show
  end

  #admin/:admin_id/users  (only admin)
  def create
    @user = @admin.users.create!(user_params)
    render :show, :id => @user, status: 201
  end


  def update
    if current_user.is_a?(User)
      @user.update_attributes!(user_params)
    else
      @user.employment_status = user_params[:employment_status]
      @user.save!
    end
    render :show , :id => @user
  end

  def destroy
    @user.destroy!
  end


  private

  def user_params
    params.permit(policy(User).permitted_attributes)
  end

  def set_user
    @user = authorize User.find(params[:id])
  end

  def set_admin
    @admin = authorize Admin.find(params[:admin_id]), policy_class: UserPolicy
  end

end
