class Site::AudiosController < ApplicationController
    layout "site"
    before_action :set_student, only: [:show, :edit, :update, :destroy]
    before_action :contabiliza_pontuacao, only: [:index]
    before_action :enrolled_courses, only: [:index, :show, :course]

    def index
        @course = current_student.levels.last.course

        # ajustar hora do servidor e remover o parametro de 3 horas
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

        @student_levels = current_student.levels.all
        @licoes = current_student.quizzes.count
        @questoes = Attempt.where(:student_id => current_student.id).count
        
        errolments = Errolment.where(student_id: current_student)
        all_courses = []
        errolments.each do |err|
          all_courses << err.level.course
        end
        @courses = all_courses.uniq
        
        
        # Ranking
        @greatest_students_br = Student.order("points DESC").first(5)
        @greatest_students_unit = current_student.unit.students.order("points DESC").first(5)

    end

    def show
    end
  
    def new
        @student = Student.new
    end
  
    def edit
    end

    def create
       

        respond_to do |format|
            if @student.save
                format.html { redirect_to backoffice_student_path(@student), notice: 'Student was successfully created.' }
                format.json { render :show, status: :created, location: backoffice_student_path(@student) }
            else
                format.html { render :new }
                format.json { render json: @student.errors, status: :unprocessable_entity }
            end
        end
    end

  def update
    respond_to do |format|
        
        if params[:student][:password].blank?
            params[:student].delete(:password)
            params[:student].delete(:password_confirmation)
        end
        
        if @student.update(student_params)
            format.html { redirect_to root_path(@student), notice: 'Perfil atualizado com sucesso!' }
            format.json { render :show, status: :ok, location: @student }
        else
            format.html { redirect_to root_path(@student), notice: 'Erro na atualização.' }

        end
    end
  end

    def destroy
        @student.destroy
        respond_to do |format|
            format.html { redirect_to backoffice_students_path, notice: 'Student was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    def course
        course_id = params[:id]
        @course = Course.find(course_id)
 
        @student_levels = current_student.levels.where(course_id: @course.id)

        errolments = Errolment.where(student_id: current_student)
        all_courses = []
        errolments.each do |err|
          all_courses << err.level.course
        end
        @courses = all_courses.uniq

         # Ranking
        @greatest_students_br = Student.order("points DESC").first(5)
        @greatest_students_unit = current_student.unit.students.order("points DESC").first(5)
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:student][:id])
    end

    def enrolled_courses
        errolments = Errolment.where(student_id: current_student)
        all_courses = []
        errolments.each do |err|
          all_courses << err.level.course
        end
        @enrolled_courses = all_courses.uniq
      end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :birthday, :email, :phone, :password, :password_confirmation, :unit_id, :avatar, errolments_attributes: [:id, :level_id, :active, :expiration, :_destroy])
    end

    def contabiliza_pontuacao
        @licoes = current_student.quizzes.count
        @questoes = Attempt.where(:student_id => current_student.id).count
        @pontos = current_student.points
    end

end
