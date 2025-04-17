require 'base64'
require 'json'
require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

def pdf_image_example(api_key, full_path)
  pdf_image_process(api_key, "#{full_path}onepage.pdf", "pdf-image-out-")
  pdf_image_process(api_key, "#{full_path}pdfnumberedinput.pdf", "pdf-multi-image-out-")
end

def pdf_image_process(api_key, full_path, outfile_name)
  resource = DynamicPDF::PdfResource.new(full_path)
  pdf_image = DynamicPDF::PdfImage.new(resource)
  pdf_image.api_key = api_key
  pdf_image.image_format = DynamicPDF::PngImageFormat.new
  response = pdf_image.process

  if response.is_successful
    response.images.each_with_index do |image, i|
      file_name = "#{OUTPUT_PATH}#{outfile_name}#{i}.png"
      File.open(file_name, 'wb') do |file|
        file.write(Base64.decode64(image.data))
      end
    end
  else
    puts JSON.pretty_generate(JSON.parse(response.json_content))
  end
end


  pdf_image_example(api_key, "#{BASE_PATH}/pdf-image/")

