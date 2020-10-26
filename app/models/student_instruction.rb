class StudentInstruction < ApplicationRecord
  belongs_to :instruction
  belongs_to :student
end
