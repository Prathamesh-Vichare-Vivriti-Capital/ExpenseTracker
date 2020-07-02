class BillsController < ApplicationController
  # before_action :set_bill, only: [:update, :destroy]



  #admins/:admin_id/bills
  #users/:user_id/bills
  def index
    @bills = current_user.bills
    @bills = @bills.where(status: params[:status]) if (params[:status])
    @bills = @bills.where(user_id: params[:user_id]) if (params[:user_id] and params[:admin_id])    #for filtering if user_id given
    @bills = @bills.where(invoice_number: params[:invoice_number]) if params[:invoice_number]
  end

  #bills/:bill_id
  def show
    @bill = authorize Bill.find(params[:id])
  end

  #users/:user_id/bills
  def create
    @user = authorize current_user, policy_class: BillPolicy
    @bill = Bill.new(bill_params)
    @bill.user_id = @user.id
    @bill = InvoiceValidator.new(@bill).check    #service to valid the invoice
    if @bill.save
      render :show, :id => @bill
    else
      render json: { error: "Not saved."}.to_json
    end
  end

  #bills/:id
  def update
    @bill = authorize Bill.find(params[:id])
    if (@bill.status == "approved") and @bill.update_attributes(bill_params)
      render :show, :id => @bill
    else
      render json: { error: "Not saved."}.to_json
    end
  end

  #bills/:id 
  def destroy
    @bill = authorize Bill.find(params[:id]), :update?
    @bill.destroy
  end

  private

    def bill_params
      params.permit( :invoice_number, :amount, :date, :description, :documents)
    end



end
