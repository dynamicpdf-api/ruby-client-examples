require 'ruby_client'
require_relative 'constants'

include DynamicPDFApi

class AddBookmarks
  def self.run(apikey, path, output_path)
    pdf = Pdf.new
    pdf.api_key = apikey

    resource_a = PdfResource.new("#{path}DocumentA.pdf")
    resource_b = PdfResource.new("#{path}DocumentB.pdf")
    resource_c = PdfResource.new("#{path}DocumentC.pdf")

    input_a = pdf.add_pdf(resource_a)
    input_a.id = "documentA"

    input_b = pdf.add_pdf(resource_b)
    input_b.id = "documentB"

    input_c = pdf.add_pdf(resource_c)
    input_c.id = "documentC"

    root_outline = pdf.out_lines.add("Three Bookmarks")
    root_outline.expanded = true

    outline_a = root_outline.children.add("DocumentA", input_a)
    outline_b = root_outline.children.add("DocumentB", input_b, 2)
    outline_c = root_outline.children.add("DocumentC", input_c)

    root_outline.color = RgbColor.red
    outline_a.color = RgbColor.orange
    outline_b.color = RgbColor.green
    outline_c.color = RgbColor.purple

    outline_d = root_outline.children.add("DynamicPDFApi Cloud API")
    outline_d.color = RgbColor.blue
    outline_d.action = UrlAction.new("https://cloud.dynamicpdf.com")

    response = pdf.process

    if response.is_successful && response.content
      File.write("#{output_path}add-bookmarks-output.pdf", response.content, mode: "wb")
    else
      puts response.error_json
    end
  end
end

AddBookmarks.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}/users-guide/", CLIENT_EXAMPLES_OUTPUT_PATH)
