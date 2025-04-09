require 'ruby_client'
require_relative 'constants'

include DynamicPDFApi

class CompletingAcroForm
  def self.run(apikey, path, output_path)
    pdf = Pdf.new
    pdf.api_key = apikey

    pdf.add_pdf('samples/fill-acro-form-pdf-endpoint/fw9AcroForm_18.pdf')

    pdf.form_fields.append(FormField.new('topmostSubform[0].Page1[0].f1_1[0]', 'Any Company, Inc.'))
    pdf.form_fields.append(FormField.new('topmostSubform[0].Page1[0].f1_2[0]', 'Any Company'))
    pdf.form_fields.append(FormField.new('topmostSubform[0].Page1[0].FederalClassification[0].c1_1[0]', '1'))
    pdf.form_fields.append(FormField.new('topmostSubform[0].Page1[0].Address[0].f1_7[0]', '123 Main Street'))
    pdf.form_fields.append(FormField.new('topmostSubform[0].Page1[0].Address[0].f1_8[0]', 'Washington, DC  22222'))
    pdf.form_fields.append(FormField.new('topmostSubform[0].Page1[0].f1_9[0]', 'Any Requester'))
    pdf.form_fields.append(FormField.new('topmostSubform[0].Page1[0].f1_10[0]', '17288825617'))
    pdf.form_fields.append(FormField.new('topmostSubform[0].Page1[0].EmployerID[0].f1_14[0]', '1234567'))
    pdf.form_fields.append(FormField.new('topmostSubform[0].Page1[0].EmployerID[0].f1_15[0]', '1234567'))

    response = pdf.process

    if response.is_successful
      File.open("#{output_path}/fill-acro-form-output.pdf", 'wb') do |file|
        file.write(response.content)
      end
    else
      response.error_json
    end
  end
end

CompletingAcroForm.run(CLIENT_EXAMPLES_API_KEY, "#{CLIENT_EXAMPLES_BASE_PATH}/fill-acro-form-pdf-endpoint/", CLIENT_EXAMPLES_OUTPUT_PATH)
