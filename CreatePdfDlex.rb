require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class CreatePdfDlex
  def self.run(apikey, path, output_path)
    run_local(apikey, path, output_path)
    run_cloud(apikey, path, output_path)
  end

  def self.run_local(apikey, path, output_path)
    pdf = Pdf.new
    pdf.api_key = apikey

    layout_data = LayoutDataResource.new("#{path}SimpleReportWithCoverPage.json")

    pdf.add_additional_resource("#{path}Northwind Logo.gif", AdditionalResourceType::IMAGE)

    pdf.add_dlex("samples/creating-pdf-pdf-endpoint/SimpleReportWithCoverPage.dlex", layout_data)

    response = pdf.process

    if response.is_successful
      File.binwrite("#{output_path}create-pdf-dlex-local-output.pdf", response.content)
    else
      puts response.error_json
    end
  end


  def self.run_cloud(apikey, path, output_path)
    pdf = Pdf.new
    pdf.api_key = apikey

    layout_data = LayoutDataResource.new("#{path}SimpleReportWithCoverPage.json")

    pdf.add_dlex("samples/creating-pdf-pdf-endpoint/SimpleReportWithCoverPage.dlex", layout_data)

    response = pdf.process

    if response.is_successful
      File.binwrite("#{output_path}create-pdf-dlex-cloud-output.pdf", response.content)
    else
      puts response.error_json
    end
  end
end

CreatePdfDlex.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}/creating-pdf-pdf-endpoint/", CLIENT_EXAMPLES_OUTPUT_PATH)
