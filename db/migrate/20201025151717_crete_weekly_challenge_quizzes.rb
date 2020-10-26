class CreteWeeklyChallengeQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :weekly_challenge_quizzes do |t|
      t.references :student, foreign_key: true
      t.references :weekly_challenge, foreign_key: true
      t.boolean :hit

      t.timestamps
    end
  end
end
