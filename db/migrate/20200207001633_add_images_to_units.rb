class AddImagesToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :images, :json
  end
end
