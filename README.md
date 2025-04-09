ruby-client-examples
=========================================

The Ruby Client Examples (`ruby-client-examples`) project uses the DynamicPDF API Ruby client library to create, merge, split, form fill, stamp, obtain metadata, convert, and secure/encrypt PDF documents.  This project contains numerous sample projects for the tutorials and examples at the [DynamicPDF API](https://dpdf.io/) website.

The DynamicPDF API consists of the following endpoints.

* `dlex-layout`
* `image-info`
* `pdf`
* `pdf-info`
* `pdf-text`
* `pdf-xmp`

For more information, please visit [DynamicPDF API](https://dpdf.io/). Support for other languages/platforms (C#, Node.js, GO, PHP, Python) is available on GitHub ([DynamicPDF API at GitHub](https://github.com/dynamicpdf-api "DynamicPDF API at GitHub")).

## Client Library (`ruby-client`)

* The Ruby client project source is available on Github ([ruby-client](https://github.com/dynamicpdf-api/ruby-client)). 
* Follow the instructions on that project to install the ruby-client.

Running Examples
----------------

To install the `ruby-client-examples` for the DynamicPDF API, run the following commands.

```bash
bundle install
```

To run all the examples at once, run `dynamicpdf-examples.rb`
```bash
ruby dynamicpdf-examples.rb
```

Each ruby.rb file can also run independently. 

await TemplatesExample.Run()

```bash
ruby <filename>.rb
```

## Resources

To obtain the resources for the project, login to [https://dpdf.io/](https://dpdf.io/) (assuming you have an account), and go to the **File Manager**. You use the `samples` folder to add the resources for the tutorials and examples from this project.

- [File Manager Samples](https://dpdf.io/docs/usersguide/environment-manager/environment-manager-sample-resources)  

You need the following samples folder in your Cloud Storage space to run all the examples.

- samples/report-with-cover-page
- samples/creating-pdf-pdf-endpoint
- samples/creating-a-report-template-designer
- samples/creating-a-page-template-designer
- samples/dlex-layout
- samples/merge-pdfs-pdf-endpoint
- samples/fill-acro-form-pdf-endpoint
- samples/creating-a-page-template-designer

Local files are in the `resources` folder.  The created PDFs are placed in the project's `output` folder, you do not need to create this folder, as constants.rb does this for you.

## Tutorials

The following table lists the available tutorials.

| Tutorial Title                                     | Project/File/Class      | Tutorial Location                                            |
| -------------------------------------------------- | ----------------------- | ------------------------------------------------------------ |
| Merging PDFs                                       | MergePdfs               | https://dpdf.io/docs/tutorials/cloud-api/merging-pdfs |
| Completing an AcroForm                             | `CompletingAcroForm`    | https://dpdf.io/docs/tutorials/cloud-api/form-completion |
| Creating a PDF Using a DLEX and the `pdf` Endpoint | `CreatingPdfDlex`       | https://dpdf.io/docs/tutorials/cloud-api/dlex-pdf-endpoint |
| Adding Bookmarks to a PDF                          | `AddBookmarks`          | https://dpdf.io/docs/tutorials/cloud-api/bookmarks |
| Creating a PDF Using the `dlex-layout` Endpoint    | `CreatingPdfDlexLayout` | https://dpdf.io/docs/tutorials/cloud-api/dlex-layout |
| Extracting Image Metadata                          | `GetImageInfo`          | https://dpdf.io/docs/tutorials/cloud-api/image-info |
| Extract PDF Metadata                               | `GetPdfInfo`            | https://dpdf.io/docs/tutorials/cloud-api/pdf-info |
| Extracting PDF's Text                              | `ExtractingText`        | https://dpdf.io/docs/tutorials/cloud-api/pdf-text |
| Extract XMP Metadata                               | `GetXmpMetaData`        | https://dpdf.io/docs/tutorials/cloud-api/pdf-xmp |

# Support

The primary source for the DynamicPDF API support is through [Stack Overflow](https://stackoverflow.com/questions/tagged/dynamicpdf-api). Please use the "[dynamicpdf-api](https://stackoverflow.com/questions/tagged/dynamicpdf-api)" tag to ask questions. Our support team actively monitors the tag and responds promptly to any questions.  Also, let us know you asked the question by following up with an email to [support@dynamicpdf.com](mailto:support@dynamicpdf.com). 

## Pro Plan Subscribers[#](https://dpdf.io/support#pro-plan-subscribers)

Ticket support is available to Pro Plan subscribers. But we still encourage you to help the community by posting on Stack Overflow when possible. You can also email [support@dynamicpdf.com](mailto:support@dynamicpdf.com) if you need to ask something specific to your use case that may not help the DynamicPDF Cloud API community.

# License

The `ruby-client-examples` library is licensed under the [MIT License](./LICENSE).
