class Gallery < ApplicationRecord
    mount_uploaders :images, ImageUploader
end
