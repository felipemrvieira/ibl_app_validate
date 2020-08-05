class AddQuestionToQuestionText < ActiveRecord::Migration[5.2]
  def change
    add_reference :question_texts, :question, foreign_key: true
    add_column :question_texts, :student_answer, :string

    
  end
end
