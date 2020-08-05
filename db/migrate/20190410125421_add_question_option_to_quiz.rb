class AddQuestionOptionToQuiz < ActiveRecord::Migration[5.2]
  def change
    add_reference :quizzes, :question_option, foreign_key: true
  end
end
