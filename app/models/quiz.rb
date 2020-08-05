class Quiz < ApplicationRecord
  belongs_to :student
  belongs_to :path
  has_many :quiz_questions, dependent: :destroy
  has_many :questions, through: :quiz_questions

  def last_question
    self.quiz_questions.last.id
  end

  # def how_many_questions
  #   self.quiz_questions.count
  # end

  def how_many_questions?
    self.path.questions.count
  end

  def questions_not_hitted(student_id)
    acertos = Attempt.where(hit: true, student_id: student_id).map(&:question_id)
    q = acertos.count > 0 ? acertos : [0]
    self.path.questions.where('id NOT IN (?)', q)
  end

  def questions_hitted(student_id)
    acertos = Attempt.where(hit: true, student_id: student_id).map(&:question_id)
    q = acertos.count > 0 ? acertos : [0]
    self.path.questions.where('id IN (?)', q)
  end

  def count_questions_hitted(student_id)
    acertos = Attempt.where(hit: true, student_id: student_id).map(&:question_id)
    q = acertos.count > 0 ? acertos : [0]
    self.path.questions.where('id IN (?)', q).count
  end

  # def count_questions_hitted
  #   self.questions.count - questions_not_hitted.count
  # end

  def percentage
    if count_questions_hitted(student_id) > 0
      (count_questions_hitted(student_id) / self.path.questions.count.to_f) * 100
    else
      0
    end
  end

  def finished
    if self.percentage >= 100
      "modal-finished"
    else
      ""
    end
  end

  def displayed?
    if self.percentage >= 100
      ""
    else
      "d-none"
    end
  end

  def last_quiz_finished?(student_id)
    #verifica se é nulo
    if Quiz.all.where('student_id' => student_id).last
      last_quiz = Quiz.all.where('student_id' => student_id).last
      if last_quiz.percentage >= 100
        true
      else
        false
      end
    else
      true
    end
  end



end
