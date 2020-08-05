class AddQuestionToQuestionCombination < ActiveRecord::Migration[5.2]
  def change
    add_reference :question_combinations, :question, foreign_key: true
  end
end
