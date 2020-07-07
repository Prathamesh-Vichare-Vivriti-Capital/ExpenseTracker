class AdminsController < ApplicationController
  before_action :auth_check, only: [:index, :show, :create, :update, :destroy]

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
    @admin = Admin.new(permitted_attributes(Admin))
    # @admin = Admin.new(admin_params1)
    # @admin.password = admin_params1["password_digest"]
    byebug
    if @admin.save
      render :show, :id => @admin
    else
      render json: {error: "Not saved"}.to_json, status: 400
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update     #change bill status or employment_status
    if params[:bill_id]    #for changing bill's status
      @bill = authorize Bill.find(params[:bill_id]), :status_update? #check if correct admin

      return(render json: {"error": "The bill status has been set to approved/rejected"}.to_json,
         status: 400) if (@bill.status != "pending")
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
        render json: {error: "Not saved"}.to_json, status: 400
      end
    elsif params[:employment_status]     #for changing user's employment status
      @user = authorize User.find(params[:user_id]), :employment_status_update?

      @user.employment_status = params[:employment_status]

      if @user.save
        render json: {message: "Saved"}.to_json
      else
        render json: {error: "Not saved"}.to_json, status: 400
      end
    else
      render json: { error: "Parameter not recognised."}.to_json, status: 400
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
  end


  private

    # Only allow a list of trusted parameters through.
    def admin_params
      params.permit(:email, :password, :name)
    end
    def admin_params1
      params.require(:admin).permit(policy(@admin).permitted_attributes)
    end

    def auth_check
      @admin = authorize current_user, policy_class: AdminPolicy
    end
end
