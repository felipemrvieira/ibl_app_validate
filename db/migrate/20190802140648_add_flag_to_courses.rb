class AddFlagToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :course_flag, :string
  end
end
