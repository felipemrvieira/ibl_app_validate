class Audio < ApplicationRecord
    mount_uploader :attachment, AttachmentUploader
    validates :title, presence: true
    belongs_to :level, optional: true
    belongs_to :audio_version, optional: true

end
