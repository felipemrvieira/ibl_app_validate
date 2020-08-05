class AddManagerToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :manager, :boolean
  end
end
