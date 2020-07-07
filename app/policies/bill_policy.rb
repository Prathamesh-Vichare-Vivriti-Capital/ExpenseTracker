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

  def show?
    (user == record.user) || (user == record.user.admin)
  end

  def create?
    user.is_a?(User) and (user.employment_status == 'working')
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

  def status_update?
    record.user.admin.id == user.id
  end

end
