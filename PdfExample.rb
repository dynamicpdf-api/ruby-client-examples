require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class PdfExample
  def self.run(apikey, output_path)
    pdf = Pdf.new
    pdf.api_key = apikey
    pdf.author = "John Doe"
    pdf.title = "My Blank PDF Page"

    page_input = pdf.add_page(1008, 612)

    page_numbering = PageNumberingElement.new(
      "1",
      ElementPlacement::TOP_RIGHT
    )
    page_numbering.color = RgbColor.red
    page_numbering.font(Font.courier)
    page_numbering.font_size = 24

    page_input.elements.push(page_numbering)

    pdf_response = pdf.process

    if pdf_response.is_successful
      File.open("#{output_path}ruby-pdf-example-output.pdf", "wb") { |file| file.write(pdf_response.content) }
    else
      puts pdf_response.error_json
    end
  end
end

PdfExample.run(CLIENT_EXAMPLES_API_KEY, CLIENT_EXAMPLES_OUTPUT_PATH)
