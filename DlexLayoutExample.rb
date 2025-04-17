require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class DlexLayoutExample
  def self.run(apikey, path, output_path)
    run_cloud(apikey, path, output_path)
    run_local(apikey, path, output_path)
  end

  def self.run_cloud(apikey, path, output_path)
    layout_data = LayoutDataResource.new("#{path}creating-pdf-dlex-layout.json")
    dlex_endpoint = DlexLayout.new("samples/creating-pdf-dlex-layout-endpoint/creating-pdf-dlex-layout.dlex", layout_data)
    dlex_endpoint.api_key = apikey

    response = dlex_endpoint.process

    if response.is_successful
      File.open("#{output_path}dlex-layout-cloud-example-output.pdf", 'wb') { |file| file.write(response.content) }
    else
      puts response.error_json
    end
  end

  def self.run_local(apikey, path, output_path)
    layout_data = LayoutDataResource.new("#{path}creating-pdf-dlex-layout.json")
    dlex_resource = DlexResource.new("#{path}creating-pdf-dlex-layout.dlex", "creating-pdf-dlex-layout.dlex")
    dlex_endpoint = DlexLayout.new(dlex_resource, layout_data)
    dlex_endpoint.api_key = apikey

    dlex_endpoint.add_additional_resource("#{CLIENT_EXAMPLES_BASE_PATH}creating-pdf-dlex-layout/creating-pdf-dlex-layout.png", "creating-pdf-dlex-layout.png")

    response = dlex_endpoint.process

    if response.is_successful
      File.open("#{output_path}dlex-layout-local-example-output.pdf", 'wb') { |file| file.write(response.content) }
    else
      puts response.error_json
    end
  end
  
  def run_from_local_with_files(api_key, base_path, output_path)
    layout_data = LayoutDataResource.new(FileUtility.get_path("#{base_path}ExampleTemplate.json"))
    dlex_resource = DlexResource.new(FileUtility.get_path("#{base_path}ExampleTemplate.dlex"), "ExampleTemplate.dlex")
    dlex_endpoint = DlexLayout.new(dlex_resource, layout_data)
  
    dlex_endpoint.add_additional_resource(FileUtility.get_path("#{base_path}template_example.pdf"), "template_example.pdf")
    dlex_endpoint.add_additional_resource(FileUtility.get_path("#{base_path}signature-one.png"), "signature-one.png")
  
    dlex_endpoint.api_key = api_key
    response = dlex_endpoint.process
  
    if response.successful?
      File.write(FileUtility.get_path("#{output_path}local-template-example-output.pdf"), response.content)
    else
      puts response.error_json
    end
  end
  

end

DlexLayoutExample.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}creating-pdf-dlex-layout/", CLIENT_EXAMPLES_OUTPUT_PATH)
