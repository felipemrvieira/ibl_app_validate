class Site::CoursesController < ApplicationController
  layout "site"

  before_action :set_ranking, only: [:index, :show]
  before_action :contabiliza_pontuacao, only: [:index, :show]
  before_action :lista_acertos, only: [:index, :show]
  before_action :enrolled_courses, only: [:index, :show]

  
  def index
    errolments = Errolment.where(student_id: current_student)
    all_courses = []
    errolments.each do |err|
      all_courses << err.level.course
    end
    @courses = all_courses.uniq

    @course = current_student.levels.last.course

    # Ranking
    @greatest_students_br = Student.order("points DESC").first(5)
    @greatest_students_unit = current_student.unit.students.order("points DESC").first(5)
  end

  def show
    course_id = params[:id]
    course = Course.find(course_id)

    @student_levels = current_student.levels.where(course_id: course.id)
    
    errolments = Errolment.where(student_id: current_student).joins(:level).where('levels.course_id': course_id )
    
    all_courses = []
    errolments.each do |err|
      all_courses << err.level.course
    end
    @courses = all_courses.uniq
    
    @course = @courses.last

  end

  private
    def enrolled_courses
      errolments = Errolment.where(student_id: current_student)
      all_courses = []
      errolments.each do |err|
        all_courses << err.level.course
      end
      @enrolled_courses = all_courses.uniq
    end

    def set_ranking
      @greatest_students_br = Student.order("points DESC").first(5)
      @greatest_students_unit = current_student.unit.students.order("points DESC").first(5)    
    end

    def contabiliza_pontuacao
        @licoes = current_student.quizzes.count
        @questoes = Attempt.where(:student_id => current_student.id).count
        @pontos = current_student.points
    end

    def lista_acertos
      @acertos_semanais = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-7).beginning_of_day, (Date.today).end_of_day+3.hours)
      @acertos_hoje = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today).beginning_of_day, (Date.today).end_of_day).count
      @acertos_1_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-1.day).beginning_of_day, (Date.today-1.day).end_of_day).count
      @acertos_2_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-2.day).beginning_of_day, (Date.today-2.day).end_of_day).count
      @acertos_3_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-3.day).beginning_of_day, (Date.today-3.day).end_of_day).count
      @acertos_4_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-4.day).beginning_of_day, (Date.today-4.day).end_of_day).count
      @acertos_5_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-5.day).beginning_of_day, (Date.today-5.day).end_of_day).count
      @acertos_6_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-6.day).beginning_of_day, (Date.today-6.day).end_of_day).count
      @acertos_7_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-7.day).beginning_of_day, (Date.today-7.day).end_of_day).count
      @acertos_8_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-8.day).beginning_of_day, (Date.today-8.day).end_of_day).count
      @acertos_9_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-9.day).beginning_of_day, (Date.today-9.day).end_of_day).count
      @acertos_10_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-10.day).beginning_of_day, (Date.today-10.day).end_of_day).count
      @acertos_11_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-11.day).beginning_of_day, (Date.today-11.day).end_of_day).count
      @acertos_12_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-12.day).beginning_of_day, (Date.today-12.day).end_of_day).count
      @acertos_13_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-13.day).beginning_of_day, (Date.today-13.day).end_of_day).count
  end
end