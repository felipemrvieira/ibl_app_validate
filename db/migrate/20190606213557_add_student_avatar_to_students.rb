class AddStudentAvatarToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :student_avatar, :string
  end
end
