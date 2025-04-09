require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class GetImageInfo
  def self.run(apikey, path)
    image_resource = ImageResource.new("#{path}dynamicpdfLogo.png")
    image_info = ImageInfo.new(image_resource)
    image_info.api_key = apikey

    response = image_info.process

    if response.is_successful
      puts response.json_content
    else
      puts response.error_json
    end
  end
end

GetImageInfo.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}get-image-info-image-info-endpoint/")
