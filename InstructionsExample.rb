require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class InstructionsExample
  def self.run(api_key, base_path, output_path)
    example_one = top_level_metadata(base_path)
    print_out(api_key, example_one, "#{output_path}ruby-top-level-metadata-output.pdf")

    example_two = fonts_example(base_path)
    print_out(api_key, example_two, "#{output_path}ruby-font-output.pdf")

    example_three = security_example(base_path)
    print_out(api_key, example_three, "#{output_path}ruby-security-output.pdf")

    example_four = merge_example(base_path)
    print_out(api_key, example_four, "#{output_path}ruby-merge-output.pdf")

    example_five = form_fields_example(base_path)
    print_out(api_key, example_five, "#{output_path}ruby-form-fields-output.pdf")

    example_six = add_outlines_for_new_pdf(base_path)
    print_out(api_key, example_six, "#{output_path}ruby-outline-create-output.pdf")

    example_seven = barcode_example(base_path)
    print_out(api_key, example_seven, "#{output_path}ruby-barcode-output.pdf")

    example_eight = template_example(base_path)
    print_out(api_key, example_eight, "#{output_path}ruby-template-output.pdf")

    example_nine = add_outlines_existing_pdf(base_path)
    print_out(api_key, example_nine, "#{output_path}ruby-existing-outline-output.pdf")

  end

  def self.print_out(api_key, pdf, output_file)
    pdf.api_key = api_key
    response = pdf.process
    if response.error_json
      puts "\n#{response.error_json}"
    else
      File.binwrite(output_file, response.content)
    end
  end

  def self.html_to_pdf(base_path)
    pdf = Pdf.new
    pdf.add_html('<html><p>This is a test.</p></html>')

    file_data = Utility.get_file_data("#{base_path}HtmlWithAllTags.html")
    resource = HtmlResource.new(file_data)
    pdf.add_html(resource)

    pdf.add_html("<html><img src='./images/logo.png'></img></html>", "https://www.dynamicpdf.com")

    pdf
  end

  def self.top_level_metadata(_base_path)
    pdf = Pdf.new
    pdf.add_page(1008, 612)
    pdf.author = 'John Doe'
    pdf.keywords = 'dynamicpdf api example pdf ruby instructions'
    pdf.creator = 'John Creator'
    pdf.subject = 'topLevel document metadata'
    pdf.title = 'Sample PDF'
    pdf
  end

  def self.fonts_example(base_path)
    pdf = Pdf.new
    page = pdf.add_page(1008, 612)

    element1 = PageNumberingElement.new('A', ElementPlacement::TOP_RIGHT)
    element1.color = RgbColor.red
    element1.font(Font.helvetica)
    element1.font_size = 42
    page.elements << element1

    cloud_font = 'samples/users-guide-resources/Calibri.otf'
    element2 = PageNumberingElement.new('B', ElementPlacement::TOP_LEFT)
    element2.color = RgbColor.dark_orange

    element2.font(Font.new(cloud_font))
    element2.font_size = 32
    page.elements << element2

    local_font = "#{base_path}cnr.otf"
    element3 = PageNumberingElement.new('C', ElementPlacement::TOP_CENTER)
    element3.color = RgbColor.green
    font = Font.from_file(local_font)
    element3.font(font)
    element3.font_size = 42
    page.elements << element3

    pdf
  end

  def self.security_example(base_path)
    pdf = Pdf.new
    pdf.add_pdf(PdfResource.new("#{base_path}DocumentB.pdf"))
    security = Aes256Security.new('myuser', 'mypassword')
    security.allow_copy = false
    security.allow_print = false
    pdf.security = security
    pdf
  end

  def self.merge_example(base_path)
    pdf = Pdf.new
    pdf.add_pdf(PdfResource.new("#{base_path}DocumentA.pdf"))
    pdf.add_image(ImageResource.new("#{base_path}DPDFLogo.png"))
    pdf.add_pdf(PdfResource.new("#{base_path}DocumentB.pdf"))
    pdf
  end

  def self.form_fields_example(base_path)
    pdf = Pdf.new
    pdf.add_pdf(PdfResource.new("#{base_path}simple-form-fill.pdf"))
    pdf.form_fields << FormField.new('nameField', 'DynamicPDF')
    pdf.form_fields << FormField.new('descriptionField', 'DynamicPDF CloudAPI. RealTime PDFs, Real FAST!')
    pdf
  end

  def self.add_outlines_for_new_pdf(_base_path)
    pdf = Pdf.new
    pdf.author = 'John Doe'
    pdf.title = 'Sample Pdf'

    page1 = pdf.add_page
    page1.elements << TextElement.new('Hello World 1', ElementPlacement::TOP_CENTER)

    page2 = pdf.add_page
    page2.elements << TextElement.new('Hello World 2', ElementPlacement::TOP_CENTER)

    page3 = pdf.add_page
    page3.elements << TextElement.new('Hello World 3', ElementPlacement::TOP_CENTER)

    root_outline = pdf.out_lines.add('Root Outline')
    root_outline.children.add('Page 1', page1)
    root_outline.children.add('Page 2', page2)
    root_outline.children.add('Page 3', page3)

    pdf
  end

  def self.add_outlines_existing_pdf(base_path)
    pdf = Pdf.new
    pdf.author = 'John Doe'
    pdf.title = 'Existing Pdf Example'

    input1 = pdf.add_pdf(PdfResource.new("#{base_path}AllPageElements.pdf"))
    input1.id = 'AllPageElements'

    input2 = pdf.add_pdf(PdfResource.new("#{base_path}OutlineExisting.pdf"))
    input2.id = 'outlineDoc1'

    root_outline = pdf.out_lines.add('Imported Outline')
    root_outline.expanded = true
    root_outline.children.add_pdf_outlines(input1)
    root_outline.children.add_pdf_outlines(input2)

    pdf
  end

  def self.barcode_example(base_path)
    pdf = Pdf.new
    pdf.author = 'John Doe'
    pdf.title = 'Barcode Example'

    input = PdfInput.new(PdfResource.new("#{base_path}DocumentA.pdf"))
    pdf.inputs << input

    template = Template.new('Temp1')
    barcode = AztecBarcodeElement.new('Hello World', ElementPlacement::TOP_CENTER, 0, 500)
    template.elements << barcode
    pdf.templates['Temp1'] = template
    input._template_id = 'Temp1'


    pdf
  end

  def self.template_example(base_path)
    pdf = Pdf.new
    pdf.author = 'John User'
    pdf.title = 'Template Example One'

    input = PdfInput.new(PdfResource.new("#{base_path}DocumentA.pdf"))
    pdf.inputs << input

    template = Template.new('Temp1')
    template.elements << TextElement.new('Hello World', ElementPlacement::TOP_CENTER)
    pdf.templates['Temp1'] = template
    input._template_id = 'Temp1'

    pdf
  end
end

InstructionsExample.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}users-guide/", CLIENT_EXAMPLES_OUTPUT_PATH)
