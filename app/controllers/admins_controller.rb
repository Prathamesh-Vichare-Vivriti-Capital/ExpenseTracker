class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.all
    render json: @admins
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      render :show, :id => @admin
    else
      render :inline => "<%= 'Sorry, not saved' %>"
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    if params[:bill_id]
      @bill = Bill.find(params[:bill_id])
      @bill.status = params[:status]
      @bill.save
    elsif params[:employment_status]
      @user = User.find(params[:user_id])
      @user.employment_status = params[:employment_status]
      @user.save
    end

  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_params
      params.permit(:email, :password, :name)
    end
end
