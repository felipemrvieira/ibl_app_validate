class AddLevelToPath < ActiveRecord::Migration[5.2]
  def change
    add_reference :paths, :level, foreign_key: true
  end
end
