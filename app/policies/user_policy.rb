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
    (user == record) or (user == record.admin)
  end

  def destroy?
    user == record
  end

  def permitted_attributes
    if user.is_a?(User)
      [:email, :password, :name]
    else
      [:email, :password, :name, :employment_status]
    end
  end

end
