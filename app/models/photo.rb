# encoding: UTF-8
require 'mini_exiftool'

class Photo < ActiveRecord::Base
  belongs_to :gallery

  scope :published, where(:published => true)

  mount_uploader :image, ::PhotoUploader

  def self.import_from_path(path)
    file_data = MiniExiftool.new path, :convert_encoding => true
    data = {
      :description => (file_data.description || file_data.file_name).encode('utf-8'),
      :city => file_data.city.try(:encode, 'utf-8'),
      :country => file_data.country(:encode, 'utf-8'),
      :image => File.open(path),
      :published => true
    }
    image = Photo.new data
    if image.save
      return image
    else
      return false
    end
  end
  
  protected
end
