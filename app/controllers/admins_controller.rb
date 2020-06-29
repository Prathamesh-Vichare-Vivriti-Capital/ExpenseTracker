class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :update, :destroy]


  # GET /admins
  # GET /admins.json
  def index
    if current_user.is_a?(Admin)
      @admins = Admin.all
      render json: @admins
    else
      render json: { error: "Not permitted."}.to_json
    end
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
    current_user.is_a?(Admin) ? (@admin = Admin.new(admin_params)) : (return(render json: { error: "Not permitted."}.to_json))
    if @admin.save
      session[:admin_id] = @admin.id
      redirect_to "/"
    else
      render json: {error: "Not saved"}.to_json
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update                        #change bill status or employment_status
    if params[:bill_id] and (Bill.find(params[:bill_id]).user.admin.id == current_user.id)
      @bill = Bill.find(params[:bill_id])
      @bill.status = params[:status]
      if (params[:reimbursement_amount]).abs > @bill.amount
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
    elsif params[:employment_status]
      @user = User.find(params[:user_id])
      return(render json: { error: "Not permitted."}.to_json) if !(@user.admin.id == current_user.id)
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
    @admin.destroy
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      if current_user?(Admin.find(params[:id]))
        @admin = current_user
      else
        render json: { error: "Not permitted."}.to_json
      end
    end

    # Only allow a list of trusted parameters through.
    def admin_params
      params.permit(:email, :password, :name)
    end

end
