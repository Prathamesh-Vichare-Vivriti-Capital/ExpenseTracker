class CommentPolicy < ApplicationPolicy

  def index?
    user == record
  end

  def show?
    user == record.commentable
  end

  def create?
    user == record
  end

end
