require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class SolutionImagesTextRecExample
  def self.run(apikey, path, output_path)
    pdf = Pdf.new
    pdf.api_key = apikey
    pdf.author = "John Doe"
    pdf.title = "My Blank PDF Page"

    page_input = pdf.add_page(1008, 612)

    text_element = TextElement.new("Hello PDF", ElementPlacement::TOP_CENTER)
    text_element.color = RgbColor.blue
    text_element.font_size = 42
    text_element.x_offset = -50
    text_element.y_offset = 100
    page_input.elements.push(text_element)

    line_element = LineElement.new(900, 150, ElementPlacement::TOP_LEFT)
    line_element.color = RgbColor.red
    line_element.x_offset = 305
    line_element.y_offset = 150
    line_element.line_style = LineStyle.dash
    line_element.width = 4
    page_input.elements.push(line_element)

    rectangle_element = RectangleElement.new(100, 500, ElementPlacement::TOP_CENTER)
    rectangle_element.x_offset = -250
    rectangle_element.y_offset = -10
    rectangle_element.corner_radius = 10
    rectangle_element.border_width = 5
    rectangle_element.border_style = LineStyle.dots
    rectangle_element.border_color = RgbColor.blue
    rectangle_element.fill_color = RgbColor.green
    page_input.elements.push(rectangle_element)

    img_resource = ImageResource.new("#{path}dynamicpdfLogo.png", "dynamicpdfLogo.png")
    image_element = ImageElement.new(img_resource, ElementPlacement::TOP_LEFT, 835, 75)
    page_input.elements.push(image_element)

    puts pdf.get_instructions_json(true)

    pdf_response = pdf.process
    if pdf_response.is_successful
      File.open("#{output_path}solution-image-text-rec-example-output.pdf", "wb") { |file| file.write(pdf_response.content) }
    else
      puts pdf_response.error_json
    end
  end
end

SolutionImagesTextRecExample.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}images-text-recs/", CLIENT_EXAMPLES_OUTPUT_PATH)
