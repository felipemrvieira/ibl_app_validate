class Site::StudentsController < ApplicationController
    layout "site"
    before_action :set_student, only: [:show, :edit, :update, :destroy]

    def change_status
        @errolment = Errolment.find(params[:id])
        @errolment.toggle(:active)
        if @errolment.save
          redirect_to backoffice_student_path(@errolment.student), notice: 'Errolment status was successfully updated.'
        end
    end

    def index
        @students = Student.all
    end

    def show
    end
  
    def new
        @student = Student.new
    end
  
    def edit
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

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:student][:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(
        :name, 
        :birthday, 
        :email, 
        :phone, :password, :password_confirmation, 
        :unit_id, 
        :avatar,
        :student_avatar,
        errolments_attributes: [:id, :level_id, :active, :expiration, :_destroy])
    end

end
