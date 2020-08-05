class AddQuestionTextToQuiz < ActiveRecord::Migration[5.2]
  def change
    add_column :quizzes, :question_text, :string
  end
end
