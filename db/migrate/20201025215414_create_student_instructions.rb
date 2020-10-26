class CreateStudentInstructions < ActiveRecord::Migration[5.2]
  def change
    create_table :student_instructions do |t|
      t.boolean :read
      t.references :instruction, foreign_key: true
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
