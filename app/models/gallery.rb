require 'tools/photo_extractor'

class Gallery < ActiveRecord::Base
  has_many :photos, :dependent => :destroy

  scope :published, where(:published => true)

  def self.import_from_archive(path)
    begin
      images = Tools::PhotoExtractor.extract(path)
      gallery = self.create :title => "#{Date.today} Gallery"
      images.each do |image|
        gallery.photos << Photo.import_from_path(image)
      end
      return gallery
    rescue
      return false
    end
  end
end
