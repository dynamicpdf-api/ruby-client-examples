require_relative 'constants'
require 'json'
require 'ruby_client'

include DynamicPDFApi

class PdfInfoExample
  def self.run(api_key, path)
    resource = PdfResource.new("#{path}fw4.pdf")
    pdf_info = PdfInfo.new(resource)
    pdf_info.api_key = api_key

    response = pdf_info.process

    if response.is_successful
      puts JSON.pretty_generate(JSON.parse(response.json_content))
    else
      puts response.error_json
    end
  end
end

PdfInfoExample.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}pdf-info/")
