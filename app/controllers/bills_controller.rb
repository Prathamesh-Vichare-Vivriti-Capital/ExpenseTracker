class BillsController < ApplicationController
  before_action :auth_check, only: [:update, :destroy]
  skip_after_action :verify_authorized, only: [:index]

  #admins/:admin_id/bills
  #users/:user_id/bills
  def index
    @bills = policy_scope(Bill)
    @bills = @bills.where(status: params[:status]) if (params[:status])  #fiter wrt status
    @bills = @bills.where(user_id: params[:user_id]) if (params[:user_id] and current_user.is_a?(Admin))    #filter wrt user_id (only admin)
    @bills = @bills.where(invoice_number: params[:invoice_number]) if params[:invoice_number]
    if params[:name] and current_user.is_a?(Admin)    #filter wrt User.name (only admin)
      @bills = @bills.where({user_id: current_user.users.where(name: params[:name]).ids})
    end
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
      render json: { error: "Not saved."}.to_json, status: 400
    end
  end

  #bills/:id
  def update
    if (@bill.status == "approved") and @bill.update_attributes(bill_params)
      render :show, :id => @bill
    else
      render json: { error: "Not saved."}.to_json, status: 400
    end
  end

  #bills/:id
  def destroy
    @bill.destroy
  end

  def preview
    @bill = authorize Bill.find(params[:id])
    @bill.documents.each do |doc|
      send_data doc.download, filename: doc.filename.sanitized, content_type: doc.content_type, disposition: 'inline'
    end
  end

  private

    def bill_params
      params.permit( :invoice_number, :amount, :date, :description, :documents)
    end

    def auth_check
      @bill = authorize Bill.find(params[:id])
    end

end
