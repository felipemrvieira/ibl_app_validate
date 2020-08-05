class AddInnerToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :inner, :string
  end
end
