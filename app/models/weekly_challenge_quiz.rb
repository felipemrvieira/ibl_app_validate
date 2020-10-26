class WeeklyChallengeQuiz < ApplicationRecord
  belongs_to :student
  belongs_to :weekly_challenge
end
