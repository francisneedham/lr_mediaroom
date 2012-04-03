require 'unix_utils'
require 'mini_exiftool'

module Tools
  class PhotoExtractor
    def self.extract(path)
      self.new.extract path
    end

    def extract(path)
      unzipped_folder = unzip path
      images = get_images unzipped_folder
      if images.length > 0
        return images
      else
        raise RuntimeError, 'There seems to be some problems with the contents of the supplied archive'
      end
    end

    private

    def get_images(folder)
      paths = [].tap do |array|
        file_names = Dir.open(folder).to_a.select{|file| file =~ /^[1-9A-Za-z].*\.jpe?g|png|gif|tiff$/} - ['config.yml']
        file_names.each do |file_name|
          array << File.join(folder, file_name)
        end
      end
      return paths
    end

    def unzip(path)
      if path =~ /\.zip$/
        return (UnixUtils.unzip path)
      else
        raise RuntimeError , 'The supplied archive is not valid'
      end
    end

  end
end
