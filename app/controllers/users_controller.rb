class UsersController < ApplicationController

  def index

  end

  def show
    @user = User.find(params[:id])
  end


  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attribute(user_params)
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end

  def delete
    Book.find(params[:id]).destroy
    redirect_to :action => 'index'

  def user_params
    params.require(:users).permit( :email, :password, :name)
  end
end
