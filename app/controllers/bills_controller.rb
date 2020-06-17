class BillsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @bills = @user.bills
  end

  def show
    @bill = Bill.find(params[:id])
  end


  def create
    @bill = Bill.new(bill_params)
    @bill.user_id = params[:user_id]

    if @bill.save
      redirect_to :action => 'index', :controller => 'bills'
    else
      render :action => 'index', :controller => 'bills'
    end
  end


  def update
    @bill = Bill.find(params[:id])
    if @bill.update_attributes(bill_params)
      redirect_to :action => 'show', :id => @bill
    else
      render :action => 'index'
    end
  end

  def destroy
    Bill.find(params[:id]).destroy
    redirect_to :action => 'index'
  end

  def bill_params
    params.permit( :invoice_number, :amount, :date, :time, :description)
  end

end
