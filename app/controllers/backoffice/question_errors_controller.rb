class Backoffice::QuestionErrorsController < BackofficeController

  before_action :set_question_error, only: [:show, :destroy]
  has_scope :by_paths, type: :array
  has_scope :keyword


  # GET /backoffice/questions
  # GET /backoffice/questions.json
  def index
    question_errors = apply_scopes(QuestionError).all
    @pagy, @question_errors = pagy(question_errors, items: 6)
    @total_question_errors = @question_errors.length
  end

  # GET /backoffice/questions/1
  # GET /backoffice/questions/1.json
  def show
  end

  # DELETE /backoffice/questions/1
  # DELETE /backoffice/questions/1.json
  def destroy
    @question_error.destroy
    respond_to do |format|
      format.html { redirect_to backoffice_question_errors_path, notice: 'O report de erro foi excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_error
      @question_error = QuestionError.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(
        :title, :description, :path_id
      )
    end
    

end



