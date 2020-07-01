class CommentsController < ApplicationController

  #admins/:admin_id/comments
  #users/:user_id/comments
  def index
    @comments = current_user.comments
    if params[:bill_id]
      @comments = Comment.all.where(bill_id: params[:bill_id])
    end
  end

  #/comments/:comment_id
  def show
    @comment = authorize Comment.find(params[:id])
  end

  #admins/:admin_id/comments
  #users/:user_id/comments
  def create
    @bill = authorize Bill.find(params[:bill_id]), policy_class: CommentPolicy

    @comment = Comment.new(comment_params)
    @comment.commentable = current_user

    if @comment.save
      CommentNotificationMailer.notify(current_user,Bill.find(comment_params[:bill_id])).deliver
      render :show, :id => @comment
    else
      render json: { error: "Not saved."}.to_json
    end
  end


  private

    def comment_params
      params.permit(:body,:bill_id)
    end

end
