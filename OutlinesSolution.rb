require 'ruby_client'
require_relative 'constants'

include DynamicPDFApi

class OutlinesSolution
  def self.run(api_key, path, output_path)

    pdf = Pdf.new
    pdf.author = "John Doe"
    pdf.title = "Sample Pdf"
    pdf.api_key = api_key

    page_input = pdf.add_page
    page_input.elements << TextElement.new("Hello World 1", ElementPlacement::TOP_CENTER)

    page_input1 = pdf.add_page
    page_input1.elements << TextElement.new("Hello World 2", ElementPlacement::TOP_CENTER)

    page_input2 = pdf.add_page
    page_input2.elements << TextElement.new("Hello World 3", ElementPlacement::TOP_CENTER)

    # Add Outline
    root_outline = pdf.out_lines.add("Root Outline")
    root_outline.children.add("Page 1", page_input)
    root_outline.children.add("Page 2", page_input1)
    root_outline.children.add("Page 3", page_input2)

    input_a = pdf.add_pdf(PdfResource.new("#{path}PdfOutlineInput.pdf"))
    root_outline.children.add_pdf_outlines(input_a)

    pdf_response = pdf.process

    if pdf_response.is_successful
      File.write("#{output_path}outlines-output.pdf", pdf_response.content, mode: 'wb')
    else
      puts pdf_response.error_json
    end
  end
end

OutlinesSolution.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}outlines/", CLIENT_EXAMPLES_OUTPUT_PATH)
