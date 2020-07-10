class UserPolicy < ApplicationPolicy

  def show?
    (user == record) || (user == record.admin)
  end

  def create?
    user == record
  end

  def index?
    user == record
  end

  def update?
    user == record
  end

  def destroy?
    user == record
  end

  def employment_status_update?
    record.admin == user
  end


end
