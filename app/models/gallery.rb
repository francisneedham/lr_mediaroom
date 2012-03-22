require 'tools/photo_extractor'

class Gallery < ActiveRecord::Base
  has_many :photos

  def self.import_from_archive(path)
    begin
      data = Tools::PhotoExtractor.extract(path)
    rescue
      return false
    end
    self.create(data['gallery'])
  end
end
