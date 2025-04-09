require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class PdfXmpExample
  def self.run(apikey, path)
    resource = PdfResource.new("#{path}fw4.pdf")
    pdf_xmp = PdfXmp.new(resource)
    pdf_xmp.api_key = apikey

    response = pdf_xmp.process

    if response.is_successful
      puts response.content
    else
      puts response.error_json
    end
  end
end

PdfXmpExample.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}pdf-info/")
