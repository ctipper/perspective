<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="db">

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
   <!-- rich-text styles: italic, bold and underline -->
   <!-- =============================================================== -->

   <xsl:template match="db:emphasis">
      <xsl:choose>
         <xsl:when test="@role=false()">
            <em><xsl:apply-templates/></em>
         </xsl:when>
         <xsl:when test="@role='bold'">
            <strong><xsl:apply-templates/></strong>
         </xsl:when>
         <xsl:when test="@role='underline'">
            <u><xsl:apply-templates/></u>
         </xsl:when>
      </xsl:choose>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- superscript, subscript -->
   <!-- =============================================================== -->

   <xsl:template match="db:superscript">
      <sup><xsl:apply-templates/></sup>
   </xsl:template>

   <xsl:template match="db:subscript">
      <sub><xsl:apply-templates/></sub>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- tele-type font -->
   <!-- =============================================================== -->

   <xsl:template match="db:literal">
      <code>
         <xsl:apply-templates/>
      </code>
   </xsl:template>
   
   <!-- =============================================================== -->
   <!-- handling of quotation marks 
        The remap attribute signifies element name in orginal markup schema
     -->
   <!-- =============================================================== -->

   <xsl:template match="db:quote">
      <xsl:choose>
         <!-- following handles single quotes -->
         <xsl:when test="@remap='sq'">&#x2018;<xsl:apply-templates/>&#x2019;</xsl:when>
         <!-- or double quotes -->
         <xsl:otherwise>&#x201C;<xsl:apply-templates/>&#x201D;</xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="db:quote" mode="header">
      <xsl:choose>
         <!-- following handles single quotes -->
         <xsl:when test="@remap='sq'">&#x2018;<xsl:apply-templates/>&#x2019;</xsl:when>
         <!-- or double quotes -->
         <xsl:otherwise>&#x201C;<xsl:apply-templates/>&#x201D;</xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="db:quote" mode="heading">
      <xsl:choose>
         <!-- following handles single quotes -->
         <xsl:when test="@remap='sq'">
            '<xsl:apply-templates/>'
         </xsl:when>
         <!-- or double quotes -->
         <xsl:otherwise>&#x0022;<xsl:apply-templates/>&#x0022;</xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- sometimes it is useful to insert a horizontal rule 
        DocBook <sbr/> element is co-opted for this purpose
     -->
   <!-- =============================================================== -->

   <xsl:template match="db:sbr">
      <!-- insert horizontal rule -->
      <xsl:element name="hr"/>
   </xsl:template>

   <xsl:template match="db:markup">
      <xsl:element name="span">
         <xsl:if test="@property=true()">
            <xsl:attribute name="style">
               <xsl:value-of select="@property"/>
            </xsl:attribute>
         </xsl:if>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

</xsl:stylesheet> 
