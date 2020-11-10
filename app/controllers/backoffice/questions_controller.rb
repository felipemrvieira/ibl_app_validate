class Backoffice::QuestionsController < BackofficeController

  before_action :set_question, only: [:show, :edit, :update, :destroy]
  has_scope :by_paths, type: :array
  has_scope :keyword

  # GET /backoffice/questions
  # GET /backoffice/questions.json
  def index
    questions = apply_scopes(Question).all
    @pagy, @questions = pagy(questions, items: 6)
    @total_questions = @questions.length
  end

  def attempts
    attempts = Attempt.order("question_id")
    @pagy, @attempts = pagy(attempts, items: 20)

  end

  def delete_attempt
    @attempt = Attempt.find(params[:id])
    if @attempt.destroy
      redirect_to backoffice_questions_attempts_path, notice: 'Tentativa excluida.'
    end
  end

  # GET /backoffice/questions/1
  # GET /backoffice/questions/1.json
  def show
  end

  # GET /backoffice/questions/new
  def new
    @question = Question.new
    authorize @question
    @path_id = params[:path]
    @weekly_challenge_bank_question_id = params[:weekly_challenge_bank_question]

    if params[:course_id].present?
      @levels = Level.where(course_id: params[:course_id])
      if request.xhr?
        respond_to do |format|
          format.json {
            render json: {levels: @levels}
          }
        end
      end
    end

    if params[:level_id].present?
      @paths = Path.where(level_id: params[:level_id])
      if request.xhr?
        respond_to do |format|
          format.json {
            render json: {paths: @paths}
          }
        end
      end
    end

  end

  # GET /backoffice/questions/1/edit
  def edit
    authorize @question
  end

  # POST /backoffice/questions
  # POST /backoffice/questions.json
  def create
    @question = Question.new(question_params)


    respond_to do |format|
      if check_if_answer_exists

        if check_if_correct_option_exists && @question.save
          format.html { redirect_to backoffice_question_path(@question), notice: 'Question was successfully created.' }
          format.json { render :show, status: :created, location: backoffice_question_path(@question) }
        else
          @question.errors.add(:question_options, "Verifique se a questão possui alternativa correta!")
          format.html { render :new }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      else
        @question.errors.add(:question_options, "Você precisa adicionar uma resposta")
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /backoffice/questions/1
  # PATCH/PUT /backoffice/questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to backoffice_question_path(@question), notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: backoffice_question_path(@question) }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /backoffice/questions/1
  # DELETE /backoffice/questions/1.json
  def destroy
    authorize @question
    @question.destroy
    respond_to do |format|
      format.html { redirect_to backoffice_questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(
        :title, :description, :path_id, :type_question, :attachment,
        question_options_attributes: [:id, :correct, :option_description, :_destroy],
        question_texts_attributes: [:id, :student_answer, :_destroy],
        question_combinations_attributes: [:id, :label, :order, :_destroy]
      )
    end

    def check_if_answer_exists
      !params[:question][:question_options_attributes].blank? ||
      !params[:question][:question_texts_attributes].blank? ||
      !params[:question][:question_combinations_attributes].blank?
    end

    def check_if_correct_option_exists
      if @question.type_question == "Múltipla Escolha"
        p = params[:question][:question_options_attributes].permit!.to_h
        p.each do |key, value|
          value.each do  |key2, value2|
            return true if value2 == "1"
          end
        end
        return false
      end
      true
    end

end



