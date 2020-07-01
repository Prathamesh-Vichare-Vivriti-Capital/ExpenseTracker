class BillPolicy < ApplicationPolicy

  def show?
    (user == record.user) || (user == record.user.admin)
  end

  def create?
    user.is_a?(User) and (user.employment_status == 'working')
  end

  def update?
    user == record.user
  end

  def status_update?
    record.user.admin.id == user.id
  end

end
