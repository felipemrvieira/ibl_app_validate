class Backoffice::ExamsController < BackofficeController
  before_action :set_exam, only: [:show, :edit, :update, :destroy]

  def index
    @exams = Exam.all
  end

  def new
    @exam = Exam.new
  end

  def create
    @exam = Exam.new(exam_params)

    if @exam.save
      redirect_to backoffice_exams_path, notice: "The exam #{@exam.title} has been uploaded."
    else
      render "new"
    end
  end

  def edit
  end

  def update
    respond_to do |format|
        if @exam.update(exam_params)
            format.html { redirect_to backoffice_exams_path(@exam), notice: 'O simulado foi atualizado.' }
            format.json { render :show, status: :ok, location: @exam }
        else
            format.html { render :edit }
            format.json { render json: @exam.errors, status: :unprocessable_entity }
        end
    end
  end

  def destroy
    @exam = Exam.find(params[:id])
    @exam.destroy
    redirect_to backoffice_exams_path, notice:  "The exam #{@exam.title} has been deleted."
  end

private
  def set_exam
    @exam = Exam.find(params[:id])
  end

  def exam_params
    params.require(:exam).permit(:title, :attachment, :level_id)
  end
end
