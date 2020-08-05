class Backoffice::QuestionAnswersController < BackofficeController
  before_action :set_question_answer, only: [:show, :edit, :update, :destroy]

  def index
    @question_answers = QuestionAnswer.all
  end

  def show
  end

  def new
    @question_answer = QuestionAnswer.new
  end

  def edit
    @question_answer
  end

  def create
    @question_answer = QuestionAnswer.new(question_answer_params)

    respond_to do |format|
      if @question_answer.save
        format.html { redirect_to backoffice_question_answer_path(@question_answer), notice: 'QuestionAnswer was successfully created.' }
        format.json { render :show, status: :created, location: backoffice_question_answer_path(@question_answer) }
      else
        format.html { render :new }
        format.json { render json: @question_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @question_answer.update(question_answer_params)
        format.html { redirect_to backoffice_question_answer_path(@question_answer), notice: 'QuestionAnswer was successfully updated.' }
        format.json { render :show, status: :ok, location: @question_answer }
      else
        format.html { render :edit }
        format.json { render json: @question_answer.errors, status: :unprocessable_entity }
      end
    end
  end

    def destroy
      @question_answer.destroy
      respond_to do |format|
        format.html { redirect_to backoffice_question_answers_path, notice: 'QuestionAnswer was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_answer
      @question_answer = QuestionAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_answer_params
      params.require(:question_answer).permit(:question, :answer)
    end

end
