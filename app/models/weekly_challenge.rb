class WeeklyChallenge < ApplicationRecord
  belongs_to :question
  has_many :weekly_challenge_quizzes, dependent: :destroy
  has_many :students, through: :weekly_challenge_quizzes
end
