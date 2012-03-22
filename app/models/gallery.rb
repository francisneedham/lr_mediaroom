require 'tools/photo_extractor'

class Gallery < ActiveRecord::Base
  has_many :photos

  def self.import_from_archive(path)
    begin
      data = Tools::PhotoExtractor.extract(path)
      self.create(data['gallery']) if data['gallery']
    rescue
      return false
    end
  end
end
