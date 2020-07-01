class UsersController < ApplicationController

  #/admins/:admin_id/users     only admin access
  def index
    authorize current_user, :create?, policy_class: UserPolicy
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

  #admin/:admin_id/users    only admin can create
  def create
    authorize params[:admin_id], policy_class: UserPolicy
    @user = User.new(user_params)
    @user.admin_id = current_user.id
    @user.employment_status = 'working'
    if @user.save
      render :show, :id => @user
    else
      render json: {error: "Not saved."}.to_json
    end
  end


  def update
    @user = authorize current_user, policy_class: UserPolicy
    if @user.update_attributes(user_params)
      render :show, :id => @user
    else
      render json: { error: "Not saved."}.to_json
    end
  end

  def destroy
    @user = authorize current_user, :update?, policy_class: UserPolicy
    @user.destroy
  end

  private

    def user_params
      params.permit( :email, :password, :name)
    end

end
