require 'ruby_client'
require_relative 'constants'

include DynamicPDFApi

class MergePdfs
  def self.run(api_key, path, output_path)
    pdf = Pdf.new
    pdf.api_key = api_key

    pdf_input = pdf.add_pdf(PdfResource.new("#{path}DocumentA.pdf"))
    pdf_input.start_page = 1
    pdf_input.page_count = 1

    pdf.add_pdf(PdfResource.new("#{path}DocumentB.pdf"))
    pdf.add_pdf("samples/merge-pdfs-pdf-endpoint/DocumentC.pdf")

    response = pdf.process

    if response.is_successful
      File.open("#{output_path}merge-pdfs-output.pdf", "wb") do |file|
        file.write(response.content)
      end
    else
      puts response.error_json
    end
  end
end

MergePdfs.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}/merge-pdfs-pdf-endpoint/", CLIENT_EXAMPLES_OUTPUT_PATH)
