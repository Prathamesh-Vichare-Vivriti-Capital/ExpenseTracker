class CommentsController < ApplicationController
  before_action :set_user, :set_admin, :set_bill, only: [:index, :create]

  #admins/:admin_id/comments
  #users/:user_id/comments
  def index
    @comments = @accessor.comments
    if params[:bill_id]
      @comments = Comment.all.where(bill_id: params[:bill_id])
    end
  end

  #/comments/:comment_id
  def show #(only creator)
    @comment = authorize Comment.find(params[:id])
  end

  #admins/:admin_id/comments
  #users/:user_id/comments
  def create
    @comment = @accessor.comments.create!(comment_params)
    CommentNotificationMailer.notify(@comment.commentable,@bill).deliver
    render :show, :id => @comment, status: 201
  end


  private

  def comment_params
    params.permit(:body,:bill_id)
  end

  def set_user
    @accessor = authorize User.find(params[:user_id]), policy_class: CommentPolicy if params[:user_id]
  end

  def set_admin
    @accessor = authorize Admin.find(params[:admin_id]), policy_class: CommentPolicy if params[:admin_id]
  end

  def set_bill
    @bill = authorize Bill.find(params[:bill_id]), :show?, policy_class: BillPolicy if params[:bill_id]
  end

end
