class UsersController < ApplicationController

  def index
    @users = Admin.find(params[:admin_id]).users
  end

  def show
    @user = User.find(params[:id])
  end


  def create
    @user = User.new(user_params)
    @user.admin_id = params[:admin_id]
    @user.employment_status = 'working'
    if @user.save
      redirect_to :action => 'index'
    else
      render :action => 'index'
    end
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'index'
    end
  end

  def destroy
    User.find(params[:id]).destroy
  end

  def user_params
    params.permit( :email, :password, :name)
  end

end
