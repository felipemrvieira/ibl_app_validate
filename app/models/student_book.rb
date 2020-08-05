class StudentBook < ApplicationRecord
  belongs_to :book
  belongs_to :student

  validates_uniqueness_of :student_id, :scope => :book_id
end
