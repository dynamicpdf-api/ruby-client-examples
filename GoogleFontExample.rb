require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class GoogleFontExample
  def self.run(apikey, output_path)
    pdf = Pdf.new
    pdf.api_key = apikey

    page_input = pdf.add_page

    font = Font.google("Anta", false, false)

    element = TextElement.new("Hello", ElementPlacement::TOP_CENTER, 150, 250)
    element.color = RgbColor.blue_violet
    element.font_size = 45

    element.font(font)

    page_input.elements.push(element)

    pdf_response = pdf.process

    if pdf_response.is_successful
      File.open("#{output_path}google-font-ruby-output.pdf", "wb") { |file| file.write(pdf_response.content) }
    else
      puts pdf_response.error_json
    end
  end
end

GoogleFontExample.run(CLIENT_EXAMPLES_API_KEY, CLIENT_EXAMPLES_OUTPUT_PATH)
