<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://docbook.org/ns/docbook"
                xmlns:xlink="http://www.w3.org/1999/xlink">

   <xsl:output method="xml" 
               encoding="UTF-8" 
               media-type="text/xml" 
               indent="yes"
               omit-xml-declaration="yes"
               doctype-public="-//OASIS//DTD DocBook V5.1//EN//XML"
               doctype-system="docbook-dtd/docbook.dtd"
               xmlns="http://docbook.org/ns/docbook"
               xmlns:xlink="https://www.w3.org/1999/xlink"/>

   <xsl:strip-space elements="*"/>

   <!-- ********************************************************************

        Copyright © 2004  Christopher Tipper

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
   <xsl:include href="perspective-dbk/info.xsl"/>
   <xsl:include href="perspective-dbk/block.xsl"/>
   <xsl:include href="perspective-dbk/lists.xsl"/>
   <xsl:include href="perspective-dbk/inline.xsl"/>
   <xsl:include href="perspective-dbk/graphics.xsl"/>
   <xsl:include href="perspective-dbk/table.xsl"/>
   <xsl:include href="perspective-dbk/xref.xsl"/>
   <xsl:include href="perspective-dbk/biblio.xsl"/>
   <xsl:include href="perspective-dbk/annotations.xsl"/>

   <!-- =============================================================== -->
   <!-- match root element -->
   <!-- =============================================================== -->

   <xsl:template match="document">
      <article version="5.0" xml:lang="en">
         <xsl:call-template name="info"/>
         <xsl:apply-templates select="body"/>
         <xsl:call-template name="biblio"/>
      </article>
   </xsl:template>
   
   <!-- =============================================================== -->
   <!-- 'root' tags -->
   <!-- =============================================================== -->

   <xsl:template match="body">
      <xsl:apply-templates/>
   </xsl:template>

</xsl:stylesheet> 
