# TCL transformer console

Tx is a Tcl/Tk GUI command console to ease the generation of output formats. It
should be fairly self-explanatory and should open with a simple double-click
once you have Tcl/Tk installed properly.

You will need to download Tcl/Tk. ActiveState provide a complete distribution
that is easy to install and use.

Go to <http://www.activestate.com/> and select the ActiveTcl download page.

On Windows, make sure that `C:\TCL\BIN` is appended to your local PATH
environment variable. Go to System Settings and select the environment variables
button in the ensuing dialog.

You will have to modify in the path variable at the start of tcl script giving
location of the fop installation.

In the addition a command-line tool, `tcmd.tcl`, is provided which it is hoped
will be of some utility.

Usage: `tclsh tcmd.tcl <option> <filename>`

Where <option> is one of -html, -web, -fo, -pdf, -docbook, -epub, -validate or
-dbvalidate. Please omit the xml filename extension in <filename>.

The -web option transforms to HTML from the DocBook source in the docbook
folder.

The -validate validates the perspective source in xml folder; -dbvalidate
validates the DocBook source in the docbook folder.

Windows users may find the following useful: "GNU utilities for Win32"
<http://unxutils.sourceforge.net/> where you may get a pre-compiled version of
the Unix utility `cat`.
