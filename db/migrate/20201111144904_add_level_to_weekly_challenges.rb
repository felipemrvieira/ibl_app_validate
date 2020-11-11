class AddLevelToWeeklyChallenges < ActiveRecord::Migration[5.2]
  def change
    add_reference :weekly_challenges, :level, foreign_key: true
  end
end
