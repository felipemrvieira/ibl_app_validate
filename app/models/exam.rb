class Exam < ApplicationRecord
    mount_uploader :attachment, AttachmentUploader
    validates :title, presence: true
    belongs_to :level

end
