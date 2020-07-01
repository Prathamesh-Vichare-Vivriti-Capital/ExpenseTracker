class CommentPolicy < ApplicationPolicy

  def show?
    (record.commentable_id == user.id) and (record.commentable_type == user.class.name)
  end

  def create?
    (record.user == user) or (record.user.admin == user)
  end

end
