class BookUploader < CarrierWave::Uploader::Base

  before :store, :set_is_public
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def content_type_whitelist
    ['application/pdf']
  end

  def extension_whitelist
    %w(pdf)
  end

  def set_is_public file
    self.fog_public = true
  end
  
end
