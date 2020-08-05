class Path < ApplicationRecord
    belongs_to :level
    has_many :questions, dependent: :destroy
    has_many :quizzes, dependent: :destroy


    def path_level_title
        return self.level.course.title+" - "+self.level.title+" - "+self.title
    end

    def show_create_quiz?(student_id)
        if Quiz.find_by(path_id: self.id, student_id: student_id)
            false
        else
            true
        end
    end
end
