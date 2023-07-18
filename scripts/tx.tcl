#!/bin/sh
# the next line restarts using wish \
exec /usr/local/bin/wish "$0" ${1+"$@"}
#
#   tx.tcl - A Tk GUI to transform XML to various formats
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
# last updated 04-05-2012

# local path settings
set path "$::env(HOME)/Applications"

wm title . Tx

# Create a frame for file-browser

frame .top -borderwidth 10
pack .top -side top -fill x

# Create the browse button

set browse [button .top.browse -text Browse -command Browse]
pack .top.browse -side right

# Create a labeled entry for the filename

label .top.l -text "File name:" -padx 0
set filename [entry .top.filename -width 20 -relief sunken]
pack .top.l -side left
pack .top.filename -side left -fill x -expand true
focus .top.browse

# Create button panel

frame .p -borderwidth 5
pack .p -side top -fill x

# Create action buttons
button .p.xhtml -text HTML -width 10 -command XsltHtml
pack .p.xhtml -side left
button .p.docbook -text DocBook -width 10 -command XsltDocBook
pack .p.docbook -side left
button .p.html -text Web -width 10 -command XsltWeb
pack .p.html -side left
button .p.valid -text Validate -width 10 -command XsltValidate
pack .p.valid -side left

# Create second button panel

frame .o -borderwidth 5
pack .o -side top -fill x

# Create more action buttons

button .o.fo -text FO -width 10 -command {XsltFO ../ fop}
pack .o.fo -side left
button .o.pdf -text PDF -width 10 -command XsltPDF
pack .o.pdf -side left

# Create log pane

frame .l
set log [text .l.log -width 60 -height 10 \
             -borderwidth 2 -relief raised -setgrid true -font {helvetica 12}\
             -yscrollcommand {.l.scroll set}]
scrollbar .l.scroll -command {.l.log yview}
pack .l.scroll -side right -fill y
pack .l.log -side left -fill both -expand true
pack .l -side top -fill both -expand true

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

# Browse for XML file

proc Browse {} {
    global filename
    set typelist {
        {"XML Files" {".xml"}}
    }
    set choice [tk_getOpenFile -filetypes $typelist -initialdir [file normalize [file join . ../xml]]]
    $filename delete 0 end
    $filename insert end $choice
}

# Transform to HTML

proc XsltHtml {} {
    global filename log
    set document [$filename get]
    set dirname [file dirname $document]
    cd $dirname
    set thisdoc [file rootname [file tail $document]]
    $log delete 1.0 end
    if [catch {exec xsltproc --stringparam file-name $thisdoc \
                   --stringparam path-name "" \
                   --output [file join ../site/ $thisdoc.htm] \
                   ../stylesheets/html-perspective.xsl [file join ../xml $thisdoc.xml]} result] {
        $log insert end $result\n
    } else {
        $log insert end "Your document is transformed to HTML.\n"
    }
}

# Transform to FO

proc XsltFO {pathname renderer} {
    global filename log
    set document [$filename get]
    set dirname [file dirname $document]
    cd $dirname
    set thisdoc [file rootname [file tail $document]]
    $log delete 1.0 end

    if [catch {exec xsltproc --stringparam file-name $thisdoc \
                   --stringparam path-name $pathname \
                   --stringparam fo-processor $renderer \
                   --output [file join ../site/pdf $thisdoc.fo] \
                   ../stylesheets/fo-perspective.xsl [file join ../xml $thisdoc.xml]} result] {
        $log insert end $result\n
    } else {
        $log insert end "Your document is transformed to Formatting-Objects.\n"
    }
}

# Read and log output

proc Log {} {
    global input log done
    if [eof $input] {
        catch {close $input}
        set done 1
        return
    } else {
        gets $input line
        $log insert end $line\n
        $log see end
    }
}

# Transform FO to PDF using FOP

proc XsltPDF {} {
    global input filename log path done

    set document [$filename get]
    set dirname [file dirname $document]
    cd $dirname
    set thisdoc [file rootname [file tail $document]]

    set fofile [file normalize [file join ../site/pdf $thisdoc.fo]]
    set pdffile [file normalize [file join ../site/pdf $thisdoc.pdf]]

    $log delete 1.0 end
    
    if [catch {open "|$path/fop/fop -c ../config/fop.xconf -fo {$fofile} -pdf {$pdffile} |& cat"} input] {
        $log insert end $input\n
    } else {
        fileevent $input readable Log
        vwait done
        $log insert end "Processing of [file rootname [file tail [$filename get]]].fo to PDF is complete.\n"
        set done 0
    }
}

# Transform to DocBook

proc XsltDocBook {} {
    global filename log
    set document [$filename get]
    set dirname [file dirname $document]
    cd $dirname
    set thisdoc [file rootname [file tail $document]]
    $log delete 1.0 end
    if [catch {exec xsltproc --output [file join ../docbook $thisdoc.xml] \
                   ../stylesheets/dbk-perspective.xsl [file join ../xml $thisdoc.xml]} result] {
        $log insert end $result\n
    } else {
        $log insert end "Your document is transformed to DocBook DTD.\n"
    }
}

# Validate XML

proc XsltValidate {} {
    global filename log path
    set document [$filename get]
    set dirname [file dirname $document]
    cd $dirname
    set schema [file join "../xml/dtd" perspective-schema.rng]
    set thisdoc [file tail $document]
    $log delete 1.0 end
    if [catch {exec java -jar $path/jing/bin/jing.jar $schema $thisdoc} result] {
        $log insert end $result\n
    } else {
        $log insert end "Your document is well-formed and validated.\n"
    }
}

# Transform to Web

proc XsltWeb {} {
    global filename log params

    set document [$filename get]
    set dirname [file dirname $document]
    cd $dirname
    set thisdoc [file rootname [file tail $document]]

    $log delete 1.0 end
    if [catch {exec xsltproc --stringparam file-name $thisdoc \
                   --stringparam path-name "" \
                   --output [file join ../site $thisdoc.html] \
                   ../stylesheets/html-dbk-perspective.xsl [file join ../docbook [urlEncode $thisdoc].xml]} result] {
        $log insert end $result\n
    } else {
        $log insert end "Your DocBook document is transformed to Web.\n"
    }
}
