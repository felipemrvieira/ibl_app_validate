class AddUnitToStudent < ActiveRecord::Migration[5.2]
  def change
    add_reference :students, :unit, foreign_key: true
  end
end
