class GroupBillsController < ApplicationController
  before_action :check_auth, only: [:show, :update, :add_bill_to_group]

  #admins/:admin_id/group_bills
  #users/:user_id/group_bills
  def index
    if params[:admin_id]
      @admin = authorize Admin.find(params[:admin_id]), policy_class: GroupBillPolicy
    else
      @user = authorize User.find(params[:user_id]), policy_class: GroupBillPolicy
    end
    @group_bills = policy_scope(GroupBill)
    @group_bills = @group_bills.where(user_id: params[:user_id]) if @admin and params[:user_id]
  end

  def show
    @bills = @group_bill.bills
  end

  #users/:user_id/group_bills/
  def create
    @user = authorize User.find(params[:user_id]), policy_class: GroupBillPolicy
    raise ::Error::NoAccessToBillError if @user.employment_status != "working"
    @group_bill = GroupBill.new(group_bill_params)
    @group_bill.user_id = @user.id
    @group_bill.save!
    render json: {message: "Created a Group Bill with name '#{@group_bill.name}'"}.to_json
  end

  #group_bills/:id
  def update
    raise ::Error::NoAccessToBillError if @group_bill.user.employment_status != "working"
    @group_bill.update_attributes!(group_bill_params)
    render json: {message: "Updated Group Bill to name '#{@group_bill.name}'"}.to_json
  end

  #group_bills/:id/add_bill_to_group
  def add_bill_to_group
    raise ::Error::NoAccessToBillError if @group_bill.user.employment_status != "working"
    @bill = Bill.new(bill_params)
    @bill.user_id = @group_bill.user_id
    @bill.group_bill_id = @group_bill.id
    @bill = InvoiceValidator.new(@bill).check    #service to valid the invoice
    @bill.save!

    @group_bill.total += @bill.amount    #increment total amount after adding bill
    @group_bill.save!

    render "bills/show", :id => @bill
  end


  private
    def group_bill_params
      params.permit(:name)
    end

    def bill_params
      params.permit( :invoice_number, :amount, :date, :description, :documents)
    end

    def check_auth
      @group_bill = authorize GroupBill.find(params[:id])
    end


end
