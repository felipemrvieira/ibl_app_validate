class AddStudentToAttempt < ActiveRecord::Migration[5.2]
  def change
    add_reference :attempts, :student, foreign_key: true
  end
end
