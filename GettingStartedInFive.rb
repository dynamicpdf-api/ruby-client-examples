require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class GettingStartedInFive
  def self.run(apikey, path, output_path)
    layout_data = LayoutDataResource.new("#{path}getting-started.json")
    dlex_endpoint = DlexLayout.new("samples/getting-started/getting-started.dlex", layout_data)
    dlex_endpoint.api_key = apikey

    response = dlex_endpoint.process

    if response.is_successful
      File.open("#{output_path}getting-started-ruby-output.pdf", 'wb') { |file| file.write(response.content) }
    else
      puts response.error_json
    end
  end
end

GettingStartedInFive.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}getting-started/", CLIENT_EXAMPLES_OUTPUT_PATH)
