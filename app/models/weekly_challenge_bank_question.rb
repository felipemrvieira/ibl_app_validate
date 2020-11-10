class WeeklyChallengeBankQuestion < ApplicationRecord
  belongs_to :level
  has_many :questions, dependent: :destroy
end
