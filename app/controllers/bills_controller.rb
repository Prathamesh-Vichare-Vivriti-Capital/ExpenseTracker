class BillsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @bills = @user.bills
  end


  def show
    @bill = Bill.find(params[:id])
  end


  def create
    @user = User.find(params[:user_id])
    if @user.employment_status == "working"
      @bill = Bill.new(bill_params)
      @bill.user_id = params[:user_id]
      @bill.status = 'pending'
      @bill.documents.attach(params[:documents])
      if @bill.save
        render :show, :id => @bill
      else
        render :inline => "<%= 'Sorry, not saved' %>"
      end
    else
      #render :json => {:out => 'Sorry you are not eligible'}.to_json
      render :inline => "<%= 'Sorry, you are not eligible.' %>"
    end
  end


  def update
    @bill = Bill.find(params[:id])
    if @bill.update_attributes(bill_params)
      render :show, :id => @bill
    else
      render :inline => "<%= 'Sorry, not saved' %>"
    end
  end

  def destroy
    Bill.find(params[:id]).destroy
  end

  private
    def bill_params
      params.permit( :invoice_number, :amount, :date, :description, :documents)
    end

end
