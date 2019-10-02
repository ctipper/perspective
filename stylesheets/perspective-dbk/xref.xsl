<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://docbook.org/ns/docbook"
                xmlns:xlink="http://www.w3.org/1999/xlink">

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
   <!-- xref elements -->
   <!-- =============================================================== -->

   <xsl:template match="a">
      <xsl:choose>
         <xsl:when test="@name=true()">
            <xsl:element name="anchor">
               <xsl:attribute name="xml:id">
                  <xsl:value-of select="@name"/>
               </xsl:attribute>
            </xsl:element>
         </xsl:when>
         <xsl:when test="substring(@href,1,1)='#' and @type=false()">
            <!-- simple link -->
            <link linkend="{substring-after(@href,'#')}"><xsl:apply-templates/></link>
         </xsl:when>
         <xsl:otherwise>
            <!-- href link -->
            <xsl:element name="link">
               <xsl:if test="@type=true()">
                  <xsl:attribute name="xlink:role">
                     <xsl:value-of select="@type"/>
                  </xsl:attribute>
               </xsl:if>
               <xsl:attribute name="xlink:href">
                  <xsl:value-of select="@href"/>
               </xsl:attribute>
               <xsl:if test="@title=true()">
                  <xsl:attribute name="xlink:title">
                     <xsl:value-of select="@title"/>
                  </xsl:attribute>
               </xsl:if>
               <xsl:if test="@property=true()">
                  <xsl:attribute name="role">
                     <xsl:value-of select="@property"/>
                  </xsl:attribute>
               </xsl:if>
               <xsl:apply-templates/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
