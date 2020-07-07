class UserPolicy < ApplicationPolicy

  def show?     #special case when another_User(params[:id]).admin.id == admin.id == current_user.admin.id
    user.is_a?(User) || (user.id == User.find(record.to_i).admin.id)
  end

  def create?
    user.is_a?(Admin)
  end

  def index?
    user.is_a?(Admin)
  end

  def update?
    user.is_a?(User)
  end

  def destroy?
    user.is_a?(User)
  end

  def employment_status_update?
    record.admin.id == user.id
  end


end
