#!/usr/bin/env tclsh
#
#   tcmd.tcl - A script to transform XML to various formats
#   Copyright © 2005  Christopher Tipper <chris.tipper@live.co.uk>
#
#   This library is free software; you can redistribute it and/or
#   modify it under the terms of the GNU Lesser General Public
#   License as published by the Free Software Foundation; either
#   version 2.1 of the License, or (at your option) any later version.
#
#   This library is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   Lesser General Public License for more details.
#
#   You should have received a copy of the GNU Lesser General Public
#   License along with this library; if not, write to the Free Software
#   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#
# last updated 2016-02-09

# local path settings
set path "$::env(HOME)/Applications"

# xsltproc has a long-standing bug accessing external entities for file names
# containing spaces e.g. https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=516916

# Encode all except "unreserved" characters; use UTF-8 for extended chars.
# See http://tools.ietf.org/html/rfc3986 §2.4 and §2.5
# https://www.rosettacode.org/wiki/URL_encoding#Tcl

proc urlEncode {str} {
    set uStr [encoding convertto utf-8 $str]
    set chRE {[^-A-Za-z0-9._~\n]};		# Newline is special case!
    set replacement {%[format "%02X" [scan "\\\0" "%c"]]}
    return [string map {"\n" "%0A"} [subst [regsub -all $chRE $uStr $replacement]]]
}

# Transform to Web

proc XsltWeb {stylesheet pathname} {
    global filename
    if [catch {exec xsltproc --stringparam file-name $filename \
                   --stringparam path-name $pathname \
                   --output ../site/$filename.html \
                   ../stylesheets/$stylesheet.xsl ../docbook/[urlEncode $filename].xml} result] {
        puts stdout $result
    } else {
        puts stdout "Your DocBook document: $filename is transformed to Web."
    }
}

# Transform to HTML

proc XsltHtml {stylesheet pathname} {
    global filename
    if [catch {exec xsltproc --stringparam file-name $filename \
                   --stringparam path-name $pathname \
                   --output ../site/$filename.htm \
                   ../stylesheets/$stylesheet.xsl ../xml/[urlEncode $filename].xml} result] {
        puts stdout $result
    } else {
        puts stdout "Your document is transformed to HTML."
    }
}

# Transform to Docbook

proc XsltDocBook {stylesheet} {
    global filename
    if [catch {exec xsltproc --output ../docbook/$filename.xml \
                   ../stylesheets/$stylesheet.xsl ../xml/[urlEncode $filename].xml} result] {
        puts stdout $result
    } else {
        puts stdout "Your document is transformed to DocBook DTD."
    }
}

# Transform to FO

proc XsltFO {stylesheet pathname renderer} {
    global filename
    if [catch {exec xsltproc --stringparam file-name $filename \
                   --stringparam path-name $pathname \
                   --stringparam fo-processor $renderer \
                   --stringparam dropped-caps no \
                   --output ../site/pdf/$filename.fo \
                   ../stylesheets/$stylesheet.xsl ../xml/[urlEncode $filename].xml} result] {
        puts stdout $result
    } else {
        puts stdout "Your document is transformed to Formatting-Objects."
    }
}

# Read and log output

proc Log {pipe} {
    global done

    if {[eof $pipe]} {
        catch {close $pipe}
        set done 1
        return
    } else {
        gets $pipe line
        puts stdout $line
    }
}

# Transform FO to PDF using FOP

proc XsltPDF {} {
    global done filename path
    # local settings on a Mac
    set path "$path/fop"

    set fofile [file normalize [file join ../site/pdf $filename.fo]]
    set pdffile [file normalize [file join ../site/pdf $filename.pdf]]
    
    if [catch {open "|$path/fop -c ../config/fop.xconf -fo {$fofile} -pdf {$pdffile} |& cat"} result] {
        puts stdout $result\n
    } else {
        fileevent $result readable [list Log $result]
        vwait done
        puts "Processing of $filename.fo to PDF is complete.\n"
    }
}

# Validate XML

proc XmlValidate {schema} {
    global filename path
    if [catch {exec java -jar $path/trang/jing.jar $schema ../xml/$filename.xml} result] {
        puts stdout $result
    } else {
        puts stdout "Your document is well-formed and validated."
    }
}

# Validate Docbook

proc DocbookValidate {schema} {
    global filename path
    if [catch {exec java -jar $path/trang/jing.jar $schema ../docbook/$filename.xml} result] {
        puts stdout $result
    } else {
        puts stdout "Your document is well-formed and validated."
    }
}

set format [lindex $argv 0]
set filename [lindex $argv 1]
if {$filename == ""} {
    puts "Usage: tclsh tcmd.tcl <option> <filename>"
    puts "Where <option> is one of -web, -html, -fo, -pdf, -docbook, -epub, "
    puts "-validate or -dbvalidate"
    puts "Please omit the filename extension in <filename>"
} else {
    switch -glob -- $format {
        -docbook {XsltDocBook dbk-perspective}
        -fo {XsltFO fo-perspective ../ fop}
        -web {XsltWeb html-dbk-perspective ""}
        -html {XsltHtml html-perspective ""}
        -pdf {XsltPDF}
        -validate {XmlValidate ../xml/dtd/perspective-schema.rng}
        -dbvalidate {DocbookValidate ../docbook/docbook-rng/docbookxi.rng}
    }
}
