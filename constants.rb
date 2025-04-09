
CLIENT_EXAMPLES_API_KEY = "DP--api-key--"
CLIENT_EXAMPLES_BASE_PATH = "./resources/"
CLIENT_EXAMPLES_OUTPUT_PATH = "./output/"

Dir.mkdir(CLIENT_EXAMPLES_OUTPUT_PATH) unless Dir.exist?(CLIENT_EXAMPLES_OUTPUT_PATH)

module Utility
  def self.get_file_data(file_path)
    File.read(file_path) if File.exist?(file_path)
  end
end
