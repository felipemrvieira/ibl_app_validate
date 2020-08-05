class AddCoverToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :cover, :string
  end
end
