class AddSiteFlagToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :site_flag, :string
  end
end
