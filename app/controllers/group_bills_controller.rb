class GroupBillsController < ApplicationController
  before_action :set_group_bill, only: [:show, :update, :add_bill_to_group, :destroy]
  before_action :set_user, only: [:index, :create]
  before_action :set_admin, only: [:index]

  #admins/:admin_id/group_bills
  #users/:user_id/group_bills
  def index
    @group_bills = policy_scope(GroupBill)
    @group_bills = @group_bills.where(user_id: params[:id]) if @admin and params[:id]
  end

  def show
    @bills = @group_bill.bills
  end

  #users/:user_id/group_bills/
  def create
    @group_bill = @user.group_bills.create!(group_bill_params)
    render json: {message: "Created a Group Bill with name '#{@group_bill.name}'"}.to_json, status: 201
  end

  #group_bills/:id
  def update
    @group_bill.update_attributes!(group_bill_params)
    render json: {message: "Updated Group Bill to name '#{@group_bill.name}'"}.to_json
  end

  #group_bills/:id/add_bill_to_group
  def add_bill_to_group
    @bill = @group_bill.bills.create!(bill_params)
    @bill.user_id = @group_bill.user_id
    @bill.save!

    @group_bill.total += @bill.amount    #increment total amount after adding bill
    @group_bill.save!

    render "bills/show", :id => @bill, status: 201
  end

  def destroy
    @group_bill.destroy!
  end


  private
  def group_bill_params
    params.permit(:name)
  end

  def bill_params
    params.permit( :invoice_number, :amount, :date, :description, :documents)
  end

  def set_group_bill
    @group_bill = authorize GroupBill.find(params[:id])
  end

  def set_user
    @user = authorize User.find(params[:user_id]), policy_class: GroupBillPolicy if params[:user_id]
  end

  def set_admin
    @admin = authorize Admin.find(params[:admin_id]), policy_class: GroupBillPolicy if params[:admin_id]
  end

end
