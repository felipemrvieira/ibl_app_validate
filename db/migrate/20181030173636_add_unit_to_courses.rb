class AddUnitToCourses < ActiveRecord::Migration[5.2]
  def change
    add_reference :courses, :unit, foreign_key: true
  end
end
