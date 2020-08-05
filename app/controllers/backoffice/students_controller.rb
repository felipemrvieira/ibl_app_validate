class Backoffice::StudentsController < BackofficeController
    before_action :set_student, only: [:show, :edit, :update, :destroy]

    has_scope :by_units, type: :array
    has_scope :keyword

    def pundit_user
        current_unit
    end

    def change_status
        @errolment = Errolment.find(params[:id])
        @errolment.toggle(:active)
        if @errolment.save
          redirect_to backoffice_student_path(@errolment.student), notice: 'Errolment status was successfully updated.'
        end
    end

    def delete_lesson
        @lesson = Quiz.find(params[:id])
        if @lesson.destroy
          redirect_to backoffice_student_path(@lesson.student), notice: 'Lição excluida.'
        end
    end

    def index
        # Utiliza Escopo definido no modelo para filtragem
        all_students = apply_scopes(Student).all
        # para escopo do pundit
        students = policy_scope(all_students)
        # Paginação
        @pagy, @students = pagy(students, items: 6)

        

    end

    def show
        authorize @student
    end
  
    def new
        @student = Student.new
        @levels = Level.all
    end
  
    def edit
        authorize @student
        @levels = Level.all
    end

    def create
        @student = Student.new(student_params)
        @student.points = 0
        @student.avatar.attach(params[:avatar])

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
            format.html { redirect_to backoffice_student_path(@student), notice: 'Student was successfully updated.' }
            format.json { render :show, status: :ok, location: @student }
        else
            format.html { render :edit }
            format.json { render json: @student.errors, status: :unprocessable_entity }
            #puts @student.errors
        end
    end
  end

    def destroy
        authorize @student
        
        @student.destroy
        respond_to do |format|
            format.html { redirect_to backoffice_students_path, notice: 'Student was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name,
                                        :birthday,
                                        :email,
                                        :phone,
                                        :password,
                                        :password_confirmation,
                                        :unit_id,
                                        :avatar,
                                        :student_avatar,
                                        :admin,
                                        errolments_attributes: [:id, :level_id, :active, :expiration, :_destroy],
                                        books_attributes: [:id, :current_page, :_destroy]
                                    )
    end

end
