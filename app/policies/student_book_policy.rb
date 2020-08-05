class StudentBookPolicy < ApplicationPolicy

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
    false
  end
  
  def update?
    false
  end
  
  def destroy?
    if user.admin
      true
    else
      false
    end
  end
end