class BillPolicy < ApplicationPolicy

  def permitted_attributes
    if user.is_a?(User)
      [:invoice_number, :amount, :date, :description, :documents]
    else
      [:status, :reimbursement_amount, :bill_id]
    end
  end

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
    raise ::Error::NoAccessToBillError if user.is_a?(User) and record.employment_status != "working"
    user == record
  end

  def update?
    raise ::Error::BillStatusChangedError if user.is_a?(User) and (record.status != "pending")
    raise ::Error::NoAccessToBillError if user.is_a?(User) and (record.user.employment_status != "working")
    (user == record.user) || (user == record.user.admin)
  end

  def destroy?
    user == record.user
  end

  def preview?
    (user == record.user) || (user == record.user.admin)
  end


end
