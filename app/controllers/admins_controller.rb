class AdminsController < ApplicationController
  before_action :auth_check, only: [:index, :show, :update, :destroy]

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
    #@admin = Admin.new(permitted_attributes(Admin))
    authorize Admin
    @admin = Admin.new(admin_params)
    # @admin.password = admin_params1["password_digest"]
    @admin.save!
    render :show, :id => @admin
  end

  # PATCH/PUT /admins/1
  def update
    @admin.update_attributes!(admin_params)
    render :show, :id => @admin
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
  end


  private

    def admin_params
      params.permit(:email, :password, :name)
    end
    def admin_params1
      params.require(:admin).permit(policy(@admin).permitted_attributes)
    end

    def auth_check
      @admin = authorize Admin.find(params[:id]), policy_class: AdminPolicy
    end
end
