class AdminsController < ApplicationController
  #before_action :set_admin, only: [:show, :update, :destroy]


  # GET /admins
  # GET /admins.json
  def index
    authorize current_user, :create?, policy_class: AdminPolicy
    @admins = Admin.all
    render json: @admins
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
    @admin = authorize current_user, :create?, policy_class: AdminPolicy
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
    @admin = authorize Admin.new(admin_params), policy_class:AdminPolicy
    if @admin.save
      session[:admin_id] = @admin.id
      redirect_to "/"
    else
      render json: {error: "Not saved"}.to_json
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update     #change bill status or employment_status
    authorize current_user, :create?, policy_class: AdminPolicy
    if params[:bill_id]    #for changing bill's status
      @bill = authorize Bill.find(params[:bill_id]), :status_update? #check if correct admin

      return(render json: {"error": "The bill status has been set to approved/rejected"}) if (@bill.status != "pending")
      (params[:status] == "approve") ? @bill.manage.approve : @bill.manage.reject  #change bill's status

      if (params[:reimbursement_amount]).abs > @bill.amount  #if reimbursement amount is absurd
        @bill.reimbursement_amount = @bill.amount
      else
        @bill.reimbursement_amount = (params[:reimbursement_amount]).abs
      end

      if @bill.save
        CommentNotificationMailer.notify_bill_status(@bill).deliver
        render json: {message: "Saved"}.to_json
      else
        render json: {error: "Not saved"}.to_json
      end
    elsif params[:employment_status]     #for changing user's employment status
      @user = authorize User.find(params[:user_id]), :employment_status_update?

      @user.employment_status = params[:employment_status]

      if @user.save
        render json: {message: "Saved"}.to_json
      else
        render json: {error: "Not saved"}.to_json
      end
    else
      render json: { error: "Not permitted."}.to_json
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    authorize current_user, :create?, policy_class: AdminPolicy
    current_user.destroy
  end


  private

    # Only allow a list of trusted parameters through.
    def admin_params
      params.permit(:email, :password, :name)
    end

end
