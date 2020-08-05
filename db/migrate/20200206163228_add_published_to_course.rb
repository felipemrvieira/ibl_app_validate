class AddPublishedToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :published, :boolean
  end
end
