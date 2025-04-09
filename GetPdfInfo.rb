require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class GetPdfInfo
  def self.run(apikey, path)
    resource = PdfResource.new("#{path}fw4.pdf")
    pdf_info = PdfInfo.new(resource)
    pdf_info.api_key = apikey

    response = pdf_info.process

    if response.is_successful
      puts response.json_content
    else
      puts response.error_json
    end
  end
end

GetPdfInfo.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}get-pdf-info-pdf-info-endpoint/")
