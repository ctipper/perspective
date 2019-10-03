# Perspective XSLT stylesheets

"Perspective" is a stylesheet distribution that allows you to publish structured
documents to web and print, using a custom
[DTD](https://en.m.wikipedia.org/wiki/Document_type_definition). The stylesheets
in this distribution allow the creation and transformation of XML to HTML, PDF
(using [Formatting-Objects](https://en.m.wikipedia.org/wiki/XSL_Formatting_Objects) via XSLT) and [DocBook](https://docbook.org/), a
widely used XML standard.

The importance of semantic markup is that you will have a clear separation
between style and content, the same content being used to generate layouts in
many media. Other solutions based on Wiki style markup of plain text don't
properly take into account document meta information, and they certainly don't
handle bibliographic data. This package provides that as well as defining a
compact and semantically meaningful XML that can be transformed to any other
schema. This package produces XML to the [Docbook schema](https://docbook.org/xml/5.1/),
for example. DocBook may then be used for transforming to present and future
formats such as the epub format (using the most recent versions of the DocBook
XSL stylesheets) used in the Sony Reader and Adobe Digital Editions.

The perspective-schema DTD allows the creation of articles with hyperlinks,
footnote entries, itemised lists, tables, image inclusions and citations, as
well as certain inline elements such as superscripts, bold, underline and
italic. It also handles proper quotation marks and a useful subset of foreign
characters and currency symbols. The XSLT stylesheet will insert a drop cap at
the start of the text body, process footnotes to provide forward and backward
links, and create author initials in bibliographic entries.

Perspective provides a DTD for a reduced markup language, 

      Namespace https://www.e-conomist.me.uk/xml/dtd/perspective-schema.dtd
      PUBLIC    "-//CTIPPER//DTD perspective XML V2.1//EN" 

A workflow can be defined as follows:

1. Create perspective DTD-based XML document based documents from the samples in
   xml folder.

2. Output may be produced by using the supplied Tcl/Tk scripts which use:
   - Output HTML using `stylesheet/html-perspective.xsl`
   - Output PDF by transforming to formatting-objects with `stylesheet/fo-perspective.xsl` and then using the fop renderer
   - Output Docbook XML using `stylesheet/dbk-perspective.xsl`

## Notes:

The supplied Tcl scripts use xsltproc and trang validator. [^1] You may use
GNOME libxml to process the pages. See your operating system
documentation. Libxml2 is bundled by default on macOS.

[^1]: A Tcl/Tk GUI is also provided to control document transformations after
the markup has been produced.

To produce PDF you will need a FO renderer, such as
[Apache FOP](https://xmlgraphics.apache.org/fop/) Installation is somewhat
involved see documentation particularly if you need non-standard fonts and
hyphenation.

Typical command-lines as follows though using the Tcl scripts is highly
recommended.

XHTML

    xsltproc.exe --stringparam file-name e-template 
                 --stringparam path-name "" --output ..\site\e-template.html 
    ..\stylesheets\html-perspective.xsl e-template.xml

PDF

    xsltproc.exe --stringparam file-name e-template 
                 --stringparam path-name ../ --stringparam fo-processor fop 
    --output ..\site\pdf\e-template.fo ..\stylesheets\fo-perspective.xsl e-template.xml

then

    fop -c ../config/fop.xconf -fo ..\site\e-template.fo -pdf ..\site\e-template.pdf 

The variable path-name refers to the path to images/ from the output directory:
uses the Unix path syntax i.e. forward slash.

Docbook

    xsltproc.exe --output ..\docbook\e-template.xml
    ..\stylesheets\dbk-perspective.xsl e-template.xml

## LICENSE

The license for this product ("LICENSE.txt") is fairly standard. Modification
of the software is at the user's own risk, all derivative products must give
proper attribution.

-- Copyright © 2005 Christopher Tipper. All Rights Reserved.
