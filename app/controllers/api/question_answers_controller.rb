class Api::QuestionAnswersController < BackofficeController
  def index
    @question_answers = QuestionAnswer.all
    render json: @question_answers
  end

end
