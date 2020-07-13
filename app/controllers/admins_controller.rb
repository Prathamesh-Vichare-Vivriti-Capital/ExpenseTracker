class AdminsController < ApplicationController
  before_action :set_admin, only: [:index, :show, :update, :destroy]

  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end


  # POST /admins
  # POST /admins.json
  def create
    authorize Admin
    @admin = Admin.create!(admin_params)
    render :show, :id => @admin, status: 201
  end

  # PATCH/PUT /admins/1
  def update
    @admin.update_attributes!(admin_params)
    render :show, :id => @admin
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy!
  end


  private

  def admin_params
    params.permit(policy(Admin).permitted_attributes)
  end

  def set_admin
    @admin = authorize Admin.find(params[:id]), policy_class: AdminPolicy
  end
end
