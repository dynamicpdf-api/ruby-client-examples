require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class DeletePages
  def self.run(apikey, path, output_path)
    pdf = Pdf.new
    pdf.api_key = apikey

    pdf_input = pdf.add_pdf(PdfResource.new("#{path}pdfnumberedinput.pdf"))
    pdf_input.start_page = 1
    pdf_input.page_count = 3

    pdf_input2 = pdf.add_pdf(PdfResource.new("#{path}pdfnumberedinput.pdf"))
    pdf_input2.start_page = 6
    pdf_input2.page_count = 2

    response = pdf.process

    if response.is_successful
      File.open("#{output_path}delete-pages-output.pdf", 'wb') { |file| file.write(response.content) }
    else
      puts response.error_json
    end
  end
end

DeletePages.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}delete-pages/", CLIENT_EXAMPLES_OUTPUT_PATH)
