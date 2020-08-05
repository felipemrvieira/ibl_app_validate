class CreateQuestionCombinations < ActiveRecord::Migration[5.2]
  def change
    create_table :question_combinations do |t|
      t.string :label
      t.string :order
      t.timestamps
    end
  end
end
