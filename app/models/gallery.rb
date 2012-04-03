require 'tools/photo_extractor'

class Gallery < ActiveRecord::Base

  UPLOAD_FOLDER = File.join(Rails.root, 'galleries')

  has_many :photos, :dependent => :destroy

  scope :published, where(:published => true)

  def self.uploaded_files
    @uploaded_files ||= []
    if @uploaded_files.empty?
      Dir[File.join(UPLOAD_FOLDER, '**', '**.*')].each do |file|
        @uploaded_files << file.gsub("#{UPLOAD_FOLDER}/", '')
      end
    end
    return @uploaded_files
  end

  def self.import_from_archive(path)
    ActiveRecord::Base.transaction do
      images = Tools::PhotoExtractor.extract(path)
      gallery = self.create :title => "#{Date.today} Gallery"
      images.each do |image|
        gallery.photos << Photo.import_from_path(image)
      end
      return gallery
    end
  end

  def cover
    gallery_photos = self.photos.published
    return gallery_photos.cover.first || gallery_photos.first
  end
end
