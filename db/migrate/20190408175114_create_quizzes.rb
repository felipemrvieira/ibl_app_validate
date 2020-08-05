class CreateQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzes do |t|
      t.references :student, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
