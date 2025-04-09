require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class PdfTextExample
  def self.run(apikey, path)
    resource = PdfResource.new("#{path}fw4.pdf")
    pdf_text = PdfText.new(resource)
    pdf_text.api_key = apikey

    response = pdf_text.process

    if response.is_successful
      puts response.json_content
    else
      puts response.error_json
    end
  end
end

PdfTextExample.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}pdf-info/")
