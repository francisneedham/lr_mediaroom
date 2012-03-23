# encoding: UTF-8
require File.expand_path('../../test_config', __FILE__)
require 'minitest/autorun'

class PhotoTest < ActiveSupport::TestCase
  
  def import_from_path_without_exif_data
    path = 'assets/no_exif.png'
    assert_difference 'Photo.count', 1 do
      image = Photo.import_from_path path
      assert 'no_exif.png', image.title
    end
  end

  def import_from_path_with_exif_data
    path = 'assets/exif.jpg'
    assert_difference 'Photo.all', 1 do
      image = Photo.import_from_path path
      assert 'Pradello, Bellano, 29/01/12 Campanile della chiesa di Pradello Photo: © Carlo Borlenghi', image.title
    end
  end


end
