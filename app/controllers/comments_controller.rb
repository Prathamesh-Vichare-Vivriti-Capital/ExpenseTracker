class CommentsController < ApplicationController

  def index
    @comments = Admin.find(params.permit(:admin_id)[:admin_id]).comments if params[:admin_id]
    @comments = User.find(params.permit(:user_id)[:user_id]).comments if params[:user_id]
  end

  def show
    @comment = Comment.find(params[:id])
  end


  def create
    @comment = Comment.new(comment_params)

    if params[:user_id]
      @temp = User.find(params.permit(:user_id)[:user_id]) if params[:user_id]
    else
      @temp = Admin.find(params.permit(:admin_id)[:admin_id]) if params[:admin_id]
    end

    @comment.commentable = @temp

    if @comment.save
      CommentNotificationMailer.notify(@temp,Bill.find(comment_params[:bill_id])).deliver
      render :show, :id => @comment
    else
      render :inline => "<%= 'Sorry, not saved' %>"
    end
  end


  private
    def comment_params
      params.permit(:body,:bill_id)
    end

end
