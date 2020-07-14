class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :update, :destroy, :preview, :bill_status_update]
  before_action :set_user, only: [:create, :index]
  before_action :set_admin, only: [:index]

  #admins/:admin_id/bills
  #users/:user_id/bills
  def index
    @bills = policy_scope(Bill)
    #filtering
    @bills = @bills.where(status: params[:status]) if (params[:status])  #fiter wrt status
    @bills = @bills.where(user_id: params[:id]) if (params[:id] and @admin)   #filter wrt user_id (only admin)
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
    @bill = @user.bills.create!(bill_params)
    render :show, :id => @bill, status: 201
  end

  #bills/:id
  def update
    if current_user.is_a?(User)
      @bill.manage.update_invoice   #reset the status of bill cauz invoice has to be validated
      @bill.update!(bill_params)
    else
      (bill_params[:status] == "approve") ? @bill.manage.approve : @bill.manage.reject  #change bill's status
      if (bill_params[:reimbursement_amount]).to_i.abs > @bill.amount  #if reimbursement amount is absurd
        @bill.reimbursement_amount = @bill.amount
      else
        @bill.reimbursement_amount = (bill_params[:reimbursement_amount]).to_i.abs
      end
      Bill.skip_callback( :save, :before, :validate_invoice)   #to avoid before save call back
      @bill.save!
      CommentNotificationMailer.notify_bill_status(@bill).deliver
    end
    render :show, :id => @bill
  end

  #bills/:id
  def destroy
    @bill.destroy!
  end

  #bills/:id/preview
  def preview
    @bill.documents.each do |doc|
      send_data doc.download, filename: doc.filename.sanitized, content_type: doc.content_type, disposition: 'inline'
    end
  end


  private
  def bill_params
    params.permit(policy(Bill).permitted_attributes)
  end

  def set_bill
    @bill = authorize Bill.find(params[:id])
  end

  def set_user
    @user = authorize User.find(params[:user_id]), policy_class: BillPolicy if params[:user_id]
  end

  def set_admin
    @admin = authorize Admin.find(params[:admin_id]), policy_class: BillPolicy if params[:admin_id]
  end

end
