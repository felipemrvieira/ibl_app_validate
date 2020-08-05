class AddPathToQuizzes < ActiveRecord::Migration[5.2]
  def change
    add_reference :quizzes, :path, foreign_key: true
  end
end
