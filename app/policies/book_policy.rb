class BookPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope
    end
  end

  
  def new?
    user.admin?
  end
  
  def create?
    user.admin?
  end
  
  def show?
    user.admin?
  end
  
  def edit?
    if user.admin
      true
    else
      false
    end
  end
  
  def update?
    user.admin?
  end
  
  def destroy?
    if user.admin
      true
    else
      false
    end
  end
end