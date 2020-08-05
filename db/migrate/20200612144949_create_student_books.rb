class CreateStudentBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :student_books do |t|
      t.integer :current_page
      t.references :book, foreign_key: true
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
