require 'tools/photo_extractor'

class Gallery < ActiveRecord::Base
  has_many :photos

  def self.import_from_archive(path)
    data = Tools::PhotoExtractor.extract(path)
    if data['gallery'].present?
      gallery = self.create(data['gallery'])
      if data['images'].present?
        data['images'].each do |image|
          gallery.photos << Photo.import_from_path(image)
        end
      end
    end
  end
end
