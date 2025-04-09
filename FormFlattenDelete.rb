require_relative 'constants'
require 'ruby_client'

include DynamicPDFApi

class FormFlattenDelete
  def self.run(apikey, path, output_path)
    pdf = Pdf.new
    pdf.api_key = apikey

    pdf.add_pdf(PdfResource.new("#{path}fw9AcroForm_14.pdf"))

    form_fields = [
      FormField.new("topmostSubform[0].Page1[0].f1_1[0]", "Any Company, Inc.").tap { |f| f.flatten = true },
      FormField.new("topmostSubform[0].Page1[0].f1_2[0]", "Any Company").tap { |f| f.remove = true },
      FormField.new("topmostSubform[0].Page1[0].FederalClassification[0].c1_1[0]", "1").tap { |f| f.flatten = true },
      FormField.new("topmostSubform[0].Page1[0].Address[0].f1_7[0]", "123 Main Street"),
      FormField.new("topmostSubform[0].Page1[0].Address[0].f1_8[0]", "Washington, DC  22222"),
      FormField.new("topmostSubform[0].Page1[0].f1_9[0]", "Any Requester"),
      FormField.new("topmostSubform[0].Page1[0].f1_10[0]", "17288825617"),
      FormField.new("topmostSubform[0].Page1[0].EmployerID[0].f1_14[0]", "1234567"),
      FormField.new("topmostSubform[0].Page1[0].EmployerID[0].f1_15[0]", "1234567").tap { |f| f.remove = true }
    ]

    form_fields.each { |field| pdf.form_fields << field }

    response = pdf.process

    if response.is_successful
      File.open("#{output_path}form-flatten-output.pdf", 'wb') { |file| file.write(response.content) }
    else
      puts response.error_json
    end
  end
end

FormFlattenDelete.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}form-field-flatten/", CLIENT_EXAMPLES_OUTPUT_PATH)
