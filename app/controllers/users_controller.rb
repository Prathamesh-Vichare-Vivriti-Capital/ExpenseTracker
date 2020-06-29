class UsersController < ApplicationController

  before_action :set_user, only: [:update, :destroy]

  #/admins/:admin_id/users     only admin access
  def index
    if current_user.is_a?(Admin)
      @users = current_user.users
    else
      render json: { error: "Admin access only."}.to_json
    end
  end

  def show
    if current_user.is_a?(User)
      @user = current_user
    elsif current_user.id == User.find(params[:id]).admin.id
      @user = User.find(params[:id])
    else
      render json: { error: "Not permitted."}.to_json
    end
  end

  #admin/:admin_id/users    only admin can create
  def create
    if current_user.is_a?(Admin)
      @user = User.new(user_params)
      @user.admin_id = current_user.id
      @user.employment_status = 'working'
      if @user.save
        render :show, :id => @user
      else
        render json: {error: "Not saved."}.to_json
      end
    else
      render json: { error: "Admin access only."}.to_json
    end
  end


  def update
    if @user.update_attributes(user_params)
      render :show, :id => @user
    else
      render json: { error: "Not saved."}.to_json
    end
  end

  def destroy
    @user.destroy
  end

  private

    def set_user
      if current_user.is_a?(User)
        @user = current_user
      else
        render json: { error: "Not permitted."}.to_json
      end
    end

    def user_params
      params.permit( :email, :password, :name)
    end

end
