class RemoveLevelFromCourse < ActiveRecord::Migration[5.2]
  def change
    remove_reference :courses, :level, index: true, foreign_key: true
  end
end
