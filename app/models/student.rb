class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable,  and :omniauthable , :registerable, :recoverable,
  devise :trackable,  :database_authenticatable,
          :validatable, :timeoutable, :rememberable

  has_one_attached :avatar, dependent: :destroy
  has_many :errolments, dependent: :destroy
  has_many :levels, through: :errolments, dependent: :destroy
  accepts_nested_attributes_for :errolments, allow_destroy: true
  belongs_to :unit
  has_many :quizzes, dependent: :destroy
  has_many :attempts, dependent: :destroy
  has_many :question_errors, dependent: :destroy

  has_many :student_achievements, dependent: :destroy
  has_many :achievements, through: :student_achievements

  has_many :weekly_challenge_quizzes, dependent: :destroy
  has_many :weekly_challenges, through: :weekly_challenge_quizzes

  has_many :student_instructions, dependent: :destroy
  has_many :instructions, through: :student_instructions

  has_many :student_books, dependent: :destroy
  has_many :books, through: :student_books
  accepts_nested_attributes_for :student_books, allow_destroy: true

  # atividades de login da gem authtrail
  has_many :login_activities, as: :user

  scope :by_units, -> unit { where(:unit => unit) }
  scope :keyword, lambda {|keyword| where(["lower(name) LIKE :term", {:term => "%#{keyword.downcase}%"}]) }

  mount_uploader :student_avatar, StudentUploader

  def current_level
    self.errolments.last.level.title
  end

  def current_level_assignment
    self.errolments.last.created_at
  end

  def count_day_logins
    # Conta quantos dias diferentes a pessoa fez login
    self.login_activities.distinct.pluck("date(created_at)").count
  end

  def quizzes_finished
    quizzes_finalizados = 0
    quizzes_do_aluno = self.quizzes

    quizzes_do_aluno.each do |quiz|
      if quiz.percentage >= 99
        quizzes_finalizados = quizzes_finalizados + 1
      end
    end

    quizzes_finalizados
  end

end
