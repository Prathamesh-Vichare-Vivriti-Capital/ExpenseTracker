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

  def index?
    user == record
  end

  def show?
    (user == record.user) || (user == record.user.admin)
  end

  def create?
    user == record
  end

  def update?
    (record.user == user)
  end

  def add_bill_to_group?
    (record.user == user)
  end
end
