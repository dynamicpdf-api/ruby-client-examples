require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class ImageInfoExample
  def self.run(apikey, path)
    run_one(apikey, path)
    run_two(apikey, path)
  end

  def self.run_one(apikey, path)
    image_resource = ImageResource.new(path + "getting-started.png")
    image_info = ImageInfo.new(image_resource)
    image_info.api_key = apikey
    response = image_info.process
    puts response.json_content
  end

  def self.run_two(apikey, path)
    image_resource = ImageResource.new(path + "multipage.tiff")
    image_info = ImageInfo.new(image_resource)
    image_info.api_key = apikey
    response = image_info.process
    puts response.json_content
  end
end

ImageInfoExample.run(CLIENT_EXAMPLES_API_KEY, CLIENT_EXAMPLES_BASE_PATH + "image-info/")
