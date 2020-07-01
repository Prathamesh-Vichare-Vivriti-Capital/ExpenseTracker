class AdminPolicy < ApplicationPolicy

  def create?
    user.is_a?(Admin)
  end

  def update?
    user.id == record.id
  end

end
