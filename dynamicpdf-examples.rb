require_relative 'constants'

puts "=========== Running all examples at once. ================================="

if !Dir.exist?(CLIENT_EXAMPLES_OUTPUT_PATH)
  FileUtils.mkdir_p(CLIENT_EXAMPLES_OUTPUT_PATH)
else
  Dir.glob("#{CLIENT_EXAMPLES_OUTPUT_PATH}/**/*").each do |file|
    File.directory?(file) ? FileUtils.rm_rf(file) : File.delete(file)
  end
end

require_relative 'AddBookmarks'
require_relative 'CompletingAcroForm'
require_relative 'CreatePdfDlex'
require_relative 'DeletePages'
require_relative 'DlexLayoutExample'
require_relative 'ExcelToPdf'
require_relative 'ExtractTextExample'
require_relative 'FormFlattenDelete'
require_relative 'GetImageInfo'
require_relative 'GetPdfInfo'
require_relative 'GettingStartedInFive'
require_relative 'GetXmpMetaData'
require_relative 'GoogleFontExample'
require_relative 'ImageConversion'
require_relative 'ImageInfoExample'
require_relative 'InstructionsExample'
require_relative 'MergePdfs'
require_relative 'OutlinesSolution'
require_relative 'PdfBarcode'
require_relative 'PdfExample'
require_relative 'PdfInfoExample'
require_relative 'PdfTextExample'
require_relative 'PdfXmpExample'
require_relative 'SolutionImagesTextRecExample'
require_relative 'SplitPdf'
require_relative 'WordToPdfExample'

puts "\n============================== All client examples completed. =============================="
