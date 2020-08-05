class LevelPolicy < ApplicationPolicy
 
  class Scope < Scope
    def resolve
      scope
    end
  end


  def new?
    false
  end

  def create?
    user.admin?
  end

  def show?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end