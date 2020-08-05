class CreateQuestionTexts < ActiveRecord::Migration[5.2]
  def change
    create_table :question_texts do |t|

      t.timestamps
    end
  end
end
