class Achievement < ApplicationRecord
    has_many :student_achievements
    has_many :students, through: :student_achievements
end
