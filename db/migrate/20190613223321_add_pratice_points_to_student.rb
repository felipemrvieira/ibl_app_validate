class AddPraticePointsToStudent < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :pratice_points, :integer
  end
end
