class UploadGalleryJob < Struct.new(:path)
  def perform
    Rails.logger.error "PATH: #{path}"
    Gallery.import_from_archive(path)
  end
end
