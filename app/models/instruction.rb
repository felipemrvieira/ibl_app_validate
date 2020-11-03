class Instruction < ApplicationRecord
  has_many :student_instructions, dependent: :destroy
  has_many :students, through: :student_instructions
end
