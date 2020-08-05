class Errolment < ApplicationRecord
  belongs_to :student
  belongs_to :level

  scope :by_units, -> unit { joins(:student).where(students: {unit_id:  unit}) }
  scope :keyword, lambda {|keyword| joins(:student).where(["name LIKE :term", {:term => "%#{keyword}%"}]) }

  def status
    if self.active
      "Ativo"
    else
      "Inativo"
    end
  end
end
