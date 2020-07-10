class CommentsController < ApplicationController

  #admins/:admin_id/comments
  #users/:user_id/comments
  def index
    if params[:admin_id]
      @accessor = authorize Admin.find(params[:admin_id]), policy_class: CommentPolicy
    else
      @accessor = authorize User.find(params[:user_id]), policy_class: CommentPolicy
    end
    @comments = @accessor.comments
    if params[:bill_id]
      authorize Bill.find(params[:bill_id]), :show?, policy_class: BillPolicy
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
    @admin = authorize Admin.find(params[:admin_id]), policy_class: CommentPolicy if params[:admin_id]
    @user = authorize User.find(params[:user_id]), policy_class: CommentPolicy if params[:user_id]
    @bill = authorize Bill.find(params[:bill_id]), :show?, policy_class: BillPolicy

    @comment = Comment.new(comment_params)
    @comment.commentable = @admin || @user
    @comment.save!
    CommentNotificationMailer.notify(@comment.commentable,@bill).deliver
    render :show, :id => @comment
  end


  private

    def comment_params
      params.permit(:body,:bill_id)
    end

end
