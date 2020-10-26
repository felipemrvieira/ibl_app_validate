class Question < ApplicationRecord
  validates :type_question, presence: true

  # Uploader do CarrierWave tambem utilizado em audio.rb
  mount_uploader :attachment, AttachmentUploader

  belongs_to :path
  has_many :quiz_questions, dependent: :destroy
  has_many :question_errors, dependent: :destroy
  has_many :quizzes, through: :quiz_questions
  has_many :attempts, dependent: :destroy

  #tipos de respostas para tipos dde questões
  has_many :question_options, dependent: :destroy
  has_many :question_texts, dependent: :destroy
  has_many :question_combinations, dependent: :destroy

  accepts_nested_attributes_for :question_options, allow_destroy: true
  accepts_nested_attributes_for :question_texts, allow_destroy: true
  accepts_nested_attributes_for :question_combinations, allow_destroy: true

  scope :by_paths, -> path { where(:path => path) }
  scope :keyword, lambda {|keyword| where(["title LIKE :term", {:term => "%#{keyword}%"}]) }

  def question_title_by_course
    if self.path
        return self.path.level.course.title+" - "+self.path.level.title+" - "+self.path.title+" - "+self.title
    else
        return self.title
    end
    # self.title
  end

  def self.power_link_sample_question
    power_link = Course.where(title: "Power Link").last
    power_link_questions = []
    power_link.levels.each do |level|
      level.paths.each do |path|
        power_link_questions << path.questions
      end
    end
    power_link_questions.first.sample(1).first.id

  end
end
