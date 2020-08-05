class Site::HomeController < ApplicationController
  layout "site"
  
  def index
    @levels = current_student.levels.all
    @courses = Course.all
    @students = Student.all
  end
end
