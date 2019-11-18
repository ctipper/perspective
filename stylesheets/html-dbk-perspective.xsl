<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                exclude-result-prefixes="db xlink">

   <xsl:output method="xml" 
               encoding="UTF-8" 
               media-type="text/html" 
               indent="yes"
               omit-xml-declaration="yes"
               xmlns="http://www.w3.org/1999/xhtml"
               doctype-system="about:legacy-compat"/>

   <xsl:strip-space elements="*"/>

   <!-- ********************************************************************

        Copyright © 2005  Christopher Tipper

        Licensed under the Apache License, Version 2.0 (the "License"); you may
        not use this file except in compliance with the License.  You may obtain
        a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

        Unless required by applicable law or agreed to in writing, software
        distributed under the License is distributed on an "AS IS" BASIS,
        WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
        See the License for the specific language governing permissions and
        limitations under the License.

        ******************************************************************** -->

   <!-- =============================================================== -->
   <!-- includes -->
   <!-- =============================================================== -->

   <xsl:include href="param.xsl"/>
   <xsl:include href="docbook-xsl/info.xsl"/>
   <xsl:include href="docbook-xsl/inline.xsl"/>
   <xsl:include href="docbook-xsl/block.xsl"/>
   <xsl:include href="docbook-xsl/lists.xsl"/>
   <xsl:include href="docbook-xsl/graphics.xsl"/>
   <xsl:include href="docbook-xsl/table.xsl"/>
   <xsl:include href="docbook-xsl/footnote.xsl"/>
   <xsl:include href="docbook-xsl/xref.xsl"/>
   <xsl:include href="docbook-xsl/biblio.xsl"/>
   <xsl:include href="docbook-xsl/annotations.xsl"/>

   <xsl:param name="body.width">700</xsl:param>            <!-- width of text -->

   <!-- =============================================================== -->
   <!-- some customisations -->
   <!-- =============================================================== -->

   <xsl:param name="media">screen</xsl:param>              <!-- options are 'screen', 'print' -->
   
   <!-- =============================================================== -->
   <!-- markup the document -->
   <!-- =============================================================== -->

   <xsl:template match="db:article">
      <html lang="en-GB">
         <head>
            <meta charset="UTF-8" />
            <meta http_equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <title><xsl:apply-templates select="db:info/db:title" mode="header"/></title>
            <xsl:if test="db:info/child::db:author">
               <xsl:call-template name="authornames"/>
            </xsl:if>
            <xsl:apply-templates select="db:info/db:copyright" mode="header"/>
            <xsl:apply-templates select="db:info/db:subtitle" mode="header"/>
            <xsl:apply-templates select="db:info/db:keywordset" mode="header"/>
            <meta name="generator" content="perspective DocBook XSL Stylesheets V2.1"/>
            <link type="text/css" rel="stylesheet" title="Classic theme" href="{$path-name}stylesheets/perspective.css"/>
            <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
            <xsl:comment>[if lt IE 9]&gt;
    <![CDATA[<script src="scripts/html5shiv.js"></script>]]>
    &lt;![endif]</xsl:comment>
         </head>
         <body style="padding: 15px;">
            <a id="top"><xsl:text> </xsl:text></a>
            <article>
               <xsl:call-template name="parse-document"/>
               <xsl:apply-templates select="//db:para/db:footnote" mode="endnotes"/>
               <xsl:apply-templates select="db:bibliography"/>
               <footer>
                  <hr/>
                  <div align="right" class="blockLabel"><a class="link" href="#top">return to Top</a></div>
                  <br/>
                  <div class="small">
                     <xsl:choose>
                        <xsl:when test="//db:info/db:copyright">
                           <xsl:text>Copyright © </xsl:text><xsl:apply-templates select="//db:info/db:copyright/db:year"/><xsl:text> </xsl:text><xsl:apply-templates select="//db:info/db:copyright/db:holder"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:text>&#160;</xsl:text>
                        </xsl:otherwise>
                     </xsl:choose>
                  </div>
               </footer>
            </article> <!-- body -->
            <nav>
               <xsl:text> </xsl:text>
            </nav> <!-- side-block -->
         </body>
      </html>
   </xsl:template>

   <xsl:template name="parse-document">
      <xsl:apply-templates select="db:info |
                                   db:section |
                                   db:para |
                                   db:mediaobject |
                                   db:epigraph |
                                   db:table |
                                   db:informaltable |
                                   db:blockquote |
                                   db:orderedlist |
                                   db:variablelist |
                                   db:itemizedlist |
                                   db:sect1 |
                                   db:anchor |
                                   db:bridgehead |
                                   db:literallayout |
                                   db:sbr"/>
   </xsl:template>
   
</xsl:stylesheet> 
