class AddQuestionToAttempt < ActiveRecord::Migration[5.2]
  def change
    add_reference :attempts, :question, foreign_key: true
    remove_column :attempts, :quiz_question_id

  end
end
