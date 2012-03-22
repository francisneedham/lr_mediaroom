# encoding: UTF-8
require 'mini_exiftool'

class Photo < ActiveRecord::Base
  belongs_to :gallery
  mount_uploader :image, ::PhotoUploader

  EXIF_DATA_MAPPING = {
    'description' => 'title'
  }

  def self.import_from_path(path)
    file_data = MiniExiftool.new path, :convert_encoding => true
    EXIF_DATA_MAPPING.each do |exif_tag, field|
      if file_data[exif_tag].present?
        field_value = file_data[exif_tag]
      else
        field_value = path.split('/').last
      end
      image = self.new
      image.send("#{field}=".to_sym, field_value)
      if image.save
        return image
      else
        return false
      end
    end
  end

end
