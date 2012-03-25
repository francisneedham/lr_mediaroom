require 'test_helper'
require 'minitest/autorun'

class GalleryTest < ActiveSupport::TestCase

  def test_import_from_invalid_archive
    assert_difference "Gallery.all.count", 0 do
      path = 'test/assets/invalid_archive.zip'
      refute Gallery.import_from_archive(path)
    end
  end

  def test_import_from_archive
    assert_difference "Gallery.all.count", 1 do
      path = 'test/assets/archive.zip'
      gallery = Gallery.import_from_archive(path)
      assert_equal 'My awesome gallery', gallery.title
      assert_equal 'ZOMG', gallery.description
    end
  end
end
