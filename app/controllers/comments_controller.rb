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
    @comment = Comment.find(params[:id])
    render json: { error: "Not permitted."}.to_json if !(@comment.commentable_id == current_user.id)
  end

  #admins/:admin_id/comments
  #users/:user_id/comments
  def create
    @bill = Bill.find(params[:bill_id])
    if (@bill.user.id == current_user.id) or (@bill.user.admin.id == current_user.id)
      @temp = current_user
    else
      return(render json: { error: "Not permitted."}.to_json)
    end

    @comment = Comment.new(comment_params)
    @comment.commentable = @temp

    if @comment.save
      CommentNotificationMailer.notify(@temp,Bill.find(comment_params[:bill_id])).deliver
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
