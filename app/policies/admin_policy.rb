class AdminPolicy < ApplicationPolicy

  def permitted_attributes
      [:email, :name, :password]
  end

  def create?
    user.is_a?(Admin)
  end

  def index?
    user == record
  end

  def show?
    user == record
  end

  def destroy?
    user == record
  end


  def update?
    user == record
  end

end
