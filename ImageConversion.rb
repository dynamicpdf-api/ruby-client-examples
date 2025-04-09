require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class ImageConversion
  def self.run(api_key, path, output_path)
    pdf = Pdf.new
    pdf.api_key = api_key

    image_resource = ImageResource.new(path + "testimage.tif")
    image_resource2 = ImageResource.new(path + "dynamicpdfLogo.png")

    image_input = pdf.add_image(image_resource)
    image_input2 = pdf.add_image(image_resource2)

    image_input.v_align = VAlign::CENTER
    image_input.align = Align::CENTER
    image_input.page_height = 1008
    image_input.page_width = 612
    image_input.expand_to_fit = false

    image_input2.v_align = VAlign::CENTER
    image_input2.align = Align::CENTER
    image_input2.page_height = 612
    image_input2.page_width = 1008
    image_input2.expand_to_fit = true

    image_input.align = Align::CENTER
    image_input2.v_align = VAlign::TOP

    response = pdf.process

    if response.is_successful
      File.open(output_path + "image-conversion-ruby-output.pdf", "wb") do |file|
        file.write(response.content)
      end
    else
      puts response.error_json
    end
  end
end

ImageConversion.run(CLIENT_EXAMPLES_API_KEY, CLIENT_EXAMPLES_BASE_PATH + "image-conversion/", CLIENT_EXAMPLES_OUTPUT_PATH)
