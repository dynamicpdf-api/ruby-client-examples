require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class ExcelToPdf
  def self.run(apikey, path, output_path)
    pdf = Pdf.new
    pdf.api_key = apikey

    pdf.add_excel(ExcelResource.new("#{path}sample-data.xlsx"))

    response = pdf.process

    if response.is_successful
      File.open("#{output_path}excel-pdf-output-ruby.pdf", 'wb') { |file| file.write(response.content) }
    else
      puts response.error_json
    end
  end
end

ExcelToPdf.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}users-guide/", CLIENT_EXAMPLES_OUTPUT_PATH)
