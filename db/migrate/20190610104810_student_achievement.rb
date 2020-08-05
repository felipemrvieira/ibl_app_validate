class StudentAchievement < ActiveRecord::Migration[5.2]
  def change
    create_table :student_achievements do |t|
      t.references :student, index: true, foreign_key: true
      t.references :achievement, index: true, foreign_key: true

      t.timestamps
    end
  end
end
