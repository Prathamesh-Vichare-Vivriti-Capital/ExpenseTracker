class BillsController < ApplicationController
  before_action :set_bill, only: [:update, :destroy]



  #admins/:admin_id/bills
  #users/:user_id/bills
  def index
    if current_user.is_a?(Admin)     #if admin accessing show all bills of his users with status pending
      @bills = current_user.bills.where(status: 'pending')
      if params[:user_id]                                        #for filtering if user_id given
        @bills = @bills.where(user_id: params[:user_id])
      elsif params[:invoice_number]
        @bills = @bills.where(invoice_number: params[:invoice_number])
      end
    else     #if user accessing show all his bills
      @bills = current_user.bills
    end
  end

  #bills/:bill_id
  def show
    @bill = Bill.find(params[:id])
    return(render json: { error: "Not permitted."}.to_json) if !(current_user?(@bill.user) || current_user?(@bill.user.admin))
  end

  #users/:user_id/bills
  def create                    #even other user route will not affect
  current_user.is_a?(User) ? (@user = current_user) : (return(render json: { error: "Not permitted."}.to_json))  #only users not admin
    if @user.employment_status == "working"
      @bill = Bill.new(bill_params)
      @bill.user_id = @user.id
      @bill = InvoiceValidator.new(@bill).check
      if @bill.save
        render :show, :id => @bill
      else
        render json: { error: "Not saved."}.to_json
      end
    else
      render json: { error: "Cannot apply for reimbursement."}.to_json
    end
  end


  def update
    if @bill.update_attributes(bill_params)
      render :show, :id => @bill
    else
      render json: { error: "Not saved."}.to_json
    end
  end

  def destroy
    @bill.destroy
  end

  private
    def set_bill
      if current_user?(Bill.find(params[:id]).user)
        @bill = Bill.find(params[:id])
      else
        render json: { error: "Not permitted."}.to_json
      end
    end

    def bill_params
      params.permit( :invoice_number, :amount, :date, :description, :documents)
    end
    
end
