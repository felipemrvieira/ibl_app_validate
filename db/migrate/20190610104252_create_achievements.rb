class CreateAchievements < ActiveRecord::Migration[5.2]
  def change
    create_table :achievements do |t|
      t.string :description
      t.string :badge_path

      t.timestamps
    end
  end
end
