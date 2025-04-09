require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class WordToPdfExample
  def self.run_one(apikey, path, output_path)
    pdf = Pdf.new
    pdf.api_key = apikey

    word_resource = WordResource.new("#{path}Doc1.docx")
    word_input = WordInput.new(word_resource)

    pdf.inputs.push(word_input)

    pdf_response = pdf.process
    if pdf_response.is_successful
      File.open("#{output_path}word-pdf-output-ruby1.pdf", 'wb') { |file| file.write(pdf_response.content) }
    else
      puts pdf_response.error_json
    end
  end

  def self.run_two(apikey, path, output_path)
    pdf = Pdf.new
    pdf.api_key = apikey

    pdf.add_word(WordResource.new("#{path}Doc1.docx"))

    pdf_response = pdf.process
    if pdf_response.is_successful
      File.open("#{output_path}word-pdf-output-ruby2.pdf", 'wb') { |file| file.write(pdf_response.content) }
    else
      puts pdf_response.error_json
    end
  end
end

WordToPdfExample.run_one(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}word-pdf/", CLIENT_EXAMPLES_OUTPUT_PATH)
WordToPdfExample.run_two(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}word-pdf/", CLIENT_EXAMPLES_OUTPUT_PATH)
