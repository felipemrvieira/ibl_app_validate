class Course < ApplicationRecord
  belongs_to :father_course, class_name: 'Course', :foreign_key => 'course_id', optional:true
  has_many :children_courses, class_name: 'Course', :foreign_key => 'course_id'

  belongs_to :unit
  has_many :levels, dependent: :delete_all
  accepts_nested_attributes_for :levels, allow_destroy: true

  mount_uploader :course_flag, FlagUploader
  mount_uploader :cover, CoverUploader
  mount_uploader :inner, InnerUploader
  mount_uploader :site_flag, InnerUploader

end
