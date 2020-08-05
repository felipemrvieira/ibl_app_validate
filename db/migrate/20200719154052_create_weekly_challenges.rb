class CreateWeeklyChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :weekly_challenges do |t|
      t.references :question, foreign_key: true
      t.date :exp

      t.timestamps
    end
  end
end
