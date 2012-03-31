class Video < ActiveRecord::Base
  
  UPLOAD_FOLDER = File.join(Rails.root, 'videos')

  mount_uploader :cover, VideoCoverUploader
  
  scope :published, where(:published => true)
  scope :recent, order('id DESC').limit(5)
  
  def self.uploaded_files
    @uploaded_files ||= []
    if @uploaded_files.empty?
      Dir[File.join(UPLOAD_FOLDER, '**', '**.*')].each do |file|
        @uploaded_files << file.gsub("#{UPLOAD_FOLDER}/", '')
      end
    end
    return @uploaded_files
  end

  def method_missing(method_name, *args)
    if method_name =~ /^(attachment_[1-9])_path$/ and self.respond_to? $1
      return File.join(UPLOAD_FOLDER, self.send($1))
    end
    super
  end
end
