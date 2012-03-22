require File.expand_path('../../test_config', __FILE__)
require 'minitest/autorun'

class GalleryTest < ActiveSupport::TestCase
  def test_import
      assert_difference "Gallery.all.count", 1 do
      path = 'test/assets/archive.zip'
      gallery = Gallery.import_from_archive(path)
      assert_equal 'My awesome gallery', gallery.title
      assert_equal 'ZOMG', gallery.description
    end
  end
end
