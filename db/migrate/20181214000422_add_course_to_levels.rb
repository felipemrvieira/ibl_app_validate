class AddCourseToLevels < ActiveRecord::Migration[5.2]
  def change
    add_reference :levels, :course, foreign_key: true
  end
end
