require 'YAML'
require 'unix_utils'
require 'mini_exiftool'

module Tools
  class PhotoExtractor
    def self.extract(path)
      self.new.extract path
    end

    def extract(path)
      unzipped_folder = unzip path
      gallery = load_config unzipped_folder
      images = get_images unzipped_folder
      if check_contents(images, gallery)
        gallery['images'] = []
        images.each do |image|
          gallery['images'] << extract_image_metadata(image)
        end
        return gallery
      else
        raise RuntimeError, 'There seems to be some problems with the contents of the supplied archive'
      end
    end

    private

    def check_contents(images, record)
      valid = false
      valid =  images.length > 0 &&
               record['gallery'] &&
               !record['gallery']['title'].nil? &&
               !record['gallery']['description'].nil? 
      return valid
    end

    def get_images(folder)
      paths = [].tap do |array|
        file_names = Dir.open(folder).to_a.select{|file| file =~ /^[1-9A-Za-z].+\.jpe?g|png|gif|tiff$/} - ['config.yml']
        file_names.each do |file_name|
          array << File.join(folder, file_name)
        end
      end
      return paths
    end

    def extract_image_metadata(image)
      data = MiniExiftool.new image
      record = {}
      record['title'] = data['description']
      return record
    end

    def unzip(path)
      if path =~ /\.zip$/
        return (UnixUtils.unzip path)
      else
        raise RuntimeError , 'The supplied archive is not valid'
      end
    end

    def load_config(path)
      config_path = File.join(path, 'config.yml')
      if File.exists?(config_path)
        return YAML.load_file(File.join(path, 'config.yml'))
      else
        raise RuntimeError, 'No configuration file found in the archive'
      end
    end
  end
end
