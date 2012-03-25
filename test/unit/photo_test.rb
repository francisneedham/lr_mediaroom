# encoding: UTF-8
require 'test_helper'
require 'minitest/autorun'

class PhotoTest < ActiveSupport::TestCase
  
  def test_import_from_path_without_exif_data
    path = 'test/assets/no_exif.png'
    image = nil
    assert_difference 'Photo.count', 1 do
      image = Photo.import_from_path path
    end
    assert_equal 'no_exif.png', image.description
  end

  def test_import_from_path_with_exif_data
    path = 'test/assets/exif.jpg'
    image = nil
    assert_difference 'Photo.count', 1 do
      image = Photo.import_from_path path
    end
    assert_equal 'Pradello, Bellano, 29/01/12.Campanile della chiesa di Pradello.Photo: © Carlo Borlenghi', image.description
    assert_equal 'Pradello, Bellano', image.city
    assert_equal 'ITA', image.country
  end


end
