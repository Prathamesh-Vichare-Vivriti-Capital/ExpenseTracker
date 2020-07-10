class BillsController < ApplicationController
  before_action :auth_check, only: [:show, :update, :destroy, :preview, :bill_status_update]

  #admins/:admin_id/bills
  #users/:user_id/bills
  def index
    if params[:admin_id]
      @admin = authorize Admin.find(params[:admin_id]), policy_class: BillPolicy
    else
      @user = authorize User.find(params[:user_id]), policy_class: BillPolicy
    end
    @bills = policy_scope(Bill)
    #filtering
    @bills = @bills.where(status: params[:status]) if (params[:status])  #fiter wrt status
    @bills = @bills.where(user_id: params[:user_id]) if (params[:user_id] and @admin)   #filter wrt user_id (only admin)
    @bills = @bills.where(invoice_number: params[:invoice_number]) if params[:invoice_number]
    if params[:name] and @admin   #filter wrt User.name (only admin)
      @bills = @bills.where({user_id: @admin.users.where(name: params[:name]).ids})
    end
  end

  #bills/:bill_id
  def show
  end

  #users/:user_id/bills
  def create
    @user = authorize User.find(params[:user_id]), policy_class: BillPolicy
    raise ::Error::NoAccessToBillError if @user.employment_status != "working"
    @bill = Bill.new(bill_params)
    @bill.user_id = @user.id
    @bill = InvoiceValidator.new(@bill).check    #service to valid the invoice
    @bill.save!
    render :show, :id => @bill
  end

  #bills/:id
  def update
    raise ::Error::BillStatusChangedError if (@bill.status != "pending")
    raise ::Error::NoAccessToBillError if @bill.user.employment_status != "working"
    @bill.update_attributes!(bill_params)
    render :show, :id => @bill
  end

  #bills/:id
  def destroy
    @bill.destroy
  end

  #bills/:id/preview
  def preview
    @bill.documents.each do |doc|
      send_data doc.download, filename: doc.filename.sanitized, content_type: doc.content_type, disposition: 'inline'
    end
  end

  def bill_status_update   #(only admin)
    (params[:status] == "approve") ? @bill.manage.approve : @bill.manage.reject  #change bill's status

    if (params[:reimbursement_amount]).abs > @bill.amount  #if reimbursement amount is absurd
      @bill.reimbursement_amount = @bill.amount
    else
      @bill.reimbursement_amount = (params[:reimbursement_amount]).abs
    end

    @bill.save!
    CommentNotificationMailer.notify_bill_status(@bill).deliver
    render :show, :id => @bill
  end

  private

    def bill_params
      params.permit( :invoice_number, :amount, :date, :description, :documents)
    end

    def auth_check
      @bill = authorize Bill.find(params[:id])
    end

end
