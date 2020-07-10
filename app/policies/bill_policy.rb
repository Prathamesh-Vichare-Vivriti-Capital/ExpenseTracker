class BillPolicy < ApplicationPolicy

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
    user == record.user
  end

  def destroy?
    user == record.user
  end

  def preview?
    (user == record.user) || (user == record.user.admin)
  end

  def bill_status_update?
    record.user.admin == user
  end

end
