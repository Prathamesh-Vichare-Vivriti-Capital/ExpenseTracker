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
    @comment.commentable = User.find(params.permit(:user_id)[:user_id]) if params[:user_id]
    @comment.commentable = Admin.find(params.permit(:admin_id)[:admin_id]) if params[:admin_id]
    if @comment.save
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
