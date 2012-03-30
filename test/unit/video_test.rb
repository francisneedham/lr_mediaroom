require 'test_helper'

class VideoTest < ActiveSupport::TestCase

  def test_uploads_list
  files = ['file1.mov', 'file2.mov', 'folder/file3.mov', 'folder/file4.mov']
    assert_equal Video.uploaded_files, files
  end

  def test_attachment_path
    video = Video.new :attachment_1 => 'file1.mov'
    assert_equal video.attachment_1_path, File.join(Video::UPLOAD_FOLDER, 'file1.mov')
  end

end
