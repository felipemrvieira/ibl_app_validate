class AddWeeklyChallengeBankQuestionIdToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :weekly_challenge_bank_question, foreign_key: true
  end
end
