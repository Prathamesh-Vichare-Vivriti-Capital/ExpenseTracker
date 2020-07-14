class GroupBillPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.is_a?(Admin)
        scope.where({user_id: user.users.ids})
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def show?
    record.user == user
  end

  def index?
    user == record
  end

  def show?
    (user == record.user) || (user == record.user.admin)
  end

  def create?
    raise ::Error::NoAccessToBillError if user.is_a?(User) and (record.employment_status != "working")
    user == record
  end

  def update?
    raise ::Error::NoAccessToBillError if user.is_a?(User) and record.user.employment_status != "working"
    record.user == user
  end

  def add_bill_to_group?
    raise ::Error::NoAccessToBillError if user.is_a?(User) and record.user.employment_status != "working"
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
