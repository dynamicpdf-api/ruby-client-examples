require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class SplitPdf
  def self.run(apikey, path, output_path)
    pdf = Pdf.new
    pdf.api_key = apikey

    pdf1 = Pdf.new
    pdf1.api_key = apikey

    split(pdf, path, output_path, 1, 3, "splitpdf-one.pdf")
    split(pdf1, path, output_path, 6, 2, "splitpdf-two.pdf")
  end

  def self.split(pdf, path, output_path, start_page, page_count, output_file)
    pdf_input = pdf.add_pdf(PdfResource.new("#{path}pdfnumberedinput.pdf"))
    pdf_input.start_page = start_page
    pdf_input.page_count = page_count

    response = pdf.process

    if response.is_successful
      File.open("#{output_path}#{output_file}", "wb") { |file| file.write(response.content) }
    else
      puts response.error_json
    end
  end
end

SplitPdf.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}split-pdf/", CLIENT_EXAMPLES_OUTPUT_PATH)
