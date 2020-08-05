class Backoffice::DashboardController < BackofficeController

  def index
    @greatest_students_br = Student.order("points DESC").first(30)
    @greatest_students_unit = current_unit.students.order("points DESC").first(30)   
    
    if current_unit.admin == true
      @units = Unit.all
    else
      @units = Unit.where(id: current_unit.id)
    end

    @levels = Level.all
     
  end
end
