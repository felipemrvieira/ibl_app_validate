class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :attachment
  validates_presence_of :cover
  
  mount_uploader :attachment, BookUploader
  mount_uploader :cover, CoverUploader
  belongs_to :level

  has_many :student_books, dependent: :destroy
  has_many :students, through: :student_books

  def course_level_book
    if self.level and self.level.course
        return self.level.course.title + " - " + self.level.title + " - " + self.title
    else
        return self.title
    end
  end

end
