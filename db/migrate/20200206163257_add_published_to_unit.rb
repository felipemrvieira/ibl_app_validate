class AddPublishedToUnit < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :published, :boolean
  end
end
