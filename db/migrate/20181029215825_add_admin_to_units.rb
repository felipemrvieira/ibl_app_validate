class AddAdminToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :admin, :boolean
  end
end
