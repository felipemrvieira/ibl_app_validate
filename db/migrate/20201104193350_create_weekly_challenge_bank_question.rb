class CreateWeeklyChallengeBankQuestion < ActiveRecord::Migration[5.2]
  def change
    create_table :weekly_challenge_bank_questions do |t|
      t.string :title
      t.references :level, foreign_key: true
    end
  end
end
