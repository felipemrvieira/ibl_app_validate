class StudentPolicy < ApplicationPolicy
 
  class Scope < Scope
    def resolve
        if user.admin?
            scope.all
        else
            scope.where(unit_id: user.id)
        end
    end
  end


  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def show?
    if user.admin
        true
    else
        record.unit_id == user.id
    end
  end

  def edit?
    if user.admin
        true
    else
        record.unit_id == user.id
    end
  end

  def update?
    if user.admin
        true
    else
        record.unit_id == user.id
    end
  end

  def destroy?
    if user.admin
        true
    else
        record.unit_id == user.id
    end
  end
end