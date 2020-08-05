class AudioVersion < ApplicationRecord
  belongs_to :level
  has_many :audios

  def couse_level_title_version
    if self.level
        return self.level.course.title+" - "+self.level.title+" - "+self.title
    else
        return self.title
    end
    # self.title
  end
end
