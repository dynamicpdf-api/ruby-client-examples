require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class PdfBarcodeExample
  def self.run(apikey, output_path)
    pdf = Pdf.new
    pdf.api_key = apikey

    page_input = pdf.add_page(1008, 612)

    barcode = Code11BarcodeElement.new("12345678", 200, ElementPlacement::TOP_CENTER, 50, 50)
    barcode.color = RgbColor.red
    page_input.elements.push(barcode)

    pdf_response = pdf.process

    if pdf_response.is_successful
      File.open("#{output_path}barcode-pdf-output.pdf", "wb") { |file| file.write(pdf_response.content) }
    else
      puts pdf_response.error_json
    end
  end
end

PdfBarcodeExample.run(CLIENT_EXAMPLES_API_KEY, CLIENT_EXAMPLES_OUTPUT_PATH)
