class UsersController < ApplicationController
  before_action :check_auth_user, only: [ :show, :update, :destroy]
  before_action :check_auth_admin, only: [ :index, :create]


  #/admins/:admin_id/users  (only admin)
  def index
    @users = @admin.users
  end

  def show
  end

  #admin/:admin_id/users  (only admin)
  def create
    @user = User.new(user_params)
    @user.admin_id = @admin.id
    @user.employment_status = 'working'
    @user.save!
    render :show, :id => @user
  end


  def update
    @user.update_attributes!(user_params)
    render :show, :id => @user
  end

  def destroy
    @user.destroy
  end

  def employment_status_update  #(only admin)
    @user = authorize User.find(params[:user_id])

    @user.employment_status = params[:employment_status]

    @user.save!
    render :show , :id => @user
  end

  private

    def user_params
      params.permit( :email, :password, :name)
    end

    def check_auth_user
      @user = authorize User.find(params[:id])
    end

    def check_auth_admin
      @admin = authorize Admin.find(params[:admin_id]), policy_class: UserPolicy
    end

end
