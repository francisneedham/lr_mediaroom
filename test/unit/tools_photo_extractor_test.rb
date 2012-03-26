require 'minitest/autorun'
require 'tools/photo_extractor'

module Tools
  class PhotoExtractorTest < MiniTest::Unit::TestCase
    def test_invalid_archive_type
      assert_raises RuntimeError, 'The supplied archive is not valid' do
        PhotoExtractor.extract 'test/assets/archive.rar'
      end
    end

    def test_invalid_archive
      assert_raises RuntimeError, 'There seems to be some problems with the contents of the supplied archive' do
        PhotoExtractor.extract 'test/assets/invalid_archive.zip'
      end
    end

    def test_valid_archive
      images = PhotoExtractor.extract 'test/assets/archive.zip'
      assert_equal images.length, 4
    end

  end
end
