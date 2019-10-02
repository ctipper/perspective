# Notes about the stylesheets

Some stylesheet parameters are defined in stylesheet/param.xsl

## Images

See e-template.xml for example markup.

### Image resolution

`$resolution` is defined to be 96dpi (dots per inch). This is the _input_
resolution, not the output resolution. Particularly for PDF output (Formatting
Objects) the `<img>` element has an optional pdfres attribute giving an integer
measured in dpi. Thus `<img pdfres="200"...>` will map to an image in the
/images/200dpi/ directory, `<img pdfres="350">` will map to an image in the
/images/350dpi/ directory and so forth. All dimensions however are calculated
using the default resolution of 96dpi, which guarantees that web and PDF will
give images of the same dimensions on a 96dpi screen (1024x768, 15" monitor).

`$image-folder` is usually defined to be the `images/` folder.

## Tables

See tropical.xml for example markup.

Similar calculations are used in defining table widths, and it may help to know
that a 16cm wide paper dimension will reflect a table just over 605 pixels wide
at 96dpi.

_Multiple_ spans will cause a problem in the DocBook output. They will be
converted, but column alignment is not _guaranteed_ to be correctly applied. The
solution to this issue turned out to be a hard-problem, possibly testing the
limits of what is possible with XSLT 1.0.

## Bibliographies

A basic template for markup of bibliographies is as follows:

```
<bibliography>
<bibitem type="article" label="McKinsey">
  <editor>Ted Hall and Bill Lewis and Stephen Nickell and Robert Solow</editor>
  <title>Driving productivity and growth in the UK economy</title>
  <month>October</month>
  <year>1998</year>
  <journal>McKinsey Global Institute</journal>
</bibitem>
</bibliography>
```

The type attribute has the alternate value "book".

The label attribute is a cross-reference, and is required.

Here is the DTD description: 

```
<!ELEMENT bibliography (bibitem)*>

<!ELEMENT bibitem       (author | editor | title | month | year | 
			   journal | publisher | edition | note)+>
<!ATTLIST bibitem 
          type          (article | book)                #REQUIRED
          label         CDATA                           #REQUIRED
>
```

Note that the editor/author field can contain multiple authors and each value is
separated by ' and '. When transforming to DocBook, a nice algorithm will parse
this information and separate surnames from forenames. Note that you will have
problems with names like Von Neumann and Van der Waals, which will produce the
undesirable V. Neumann and V. d. Waals in the output. I have no workaround, but
I think you will agree that the markup schema is succinct enough to enable easy
hand-coding. You will have no problems with double-barrelled English surnames
such as Pinkerton-Smith. (The space is significant).

The note field allows more extensive comments including links. This is useful
especially for journal articles, though I can envision links to Amazon titles in
this field also. The perspective DTD uses normal HTML conventions for
hyperlinks.

## Tcl scripts

Options have been included to render PDF documents on OS X or Windows, but you
will need to comment-out/uncomment some lines in the scripts. Please don't feel
inhibited from editing the source code.
