class AdminPolicy < ApplicationPolicy

  def permitted_attributes
      [:email, :name, :password_digest]
  end

  def create?
    user.is_a?(Admin)
  end

  def index?
    user.is_a?(Admin)
  end

  def show?
    user.is_a?(Admin)
  end

  def destroy?
    user.is_a?(Admin)
  end


  def update?
    user.is_a?(Admin)
  end

end
