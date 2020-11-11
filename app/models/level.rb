class Level < ApplicationRecord
    belongs_to :course
    has_many :weekly_challenge_bank_questions, dependent: :destroy
    has_many :weekly_challenges, dependent: :destroy
    has_many :paths, dependent: :destroy
    has_many :errolments, dependent: :destroy
    has_many :students, through: :errolments
    has_many :exams
    has_many :audios
    has_many :audio_versions
    has_many :books, through: :student_books

    def couse_level_title
        if self.course
            return self.course.title+" - "+self.title
        else
            return self.title
        end
        # self.title
    end

end
