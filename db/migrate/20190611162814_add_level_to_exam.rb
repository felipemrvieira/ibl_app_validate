class AddLevelToExam < ActiveRecord::Migration[5.2]
  def change
    add_reference :exams, :level, foreign_key: true
  end
end
