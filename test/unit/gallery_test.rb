require 'test_helper'
require 'minitest/autorun'

class GalleryTest < ActiveSupport::TestCase

  def test_import_from_invalid_archive
    assert_raise RuntimeError do
      path = 'test/assets/invalid_archive.zip'
      refute Gallery.import_from_archive(path)
    end
  end

  def test_import_from_archive
    assert_difference "Gallery.all.count", 1 do
      path = 'test/assets/archive.zip'
      gallery = Gallery.import_from_archive(path)
      assert_equal "#{Date.today} Gallery", gallery.title
    end
  end
end
