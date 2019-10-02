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

   <xsl:template match="db:annotation">
      <xsl:text> </xsl:text>
   </xsl:template>

   <xsl:template match="db:title" mode="annotation">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="db:para" mode="annotation">
      <xsl:element name="p">
         <xsl:if test="@condition=true()">
            <xsl:attribute name="class">
               <xsl:value-of select="string(@condition)"/>
            </xsl:attribute>
         </xsl:if>
         <xsl:if test="@property=true()">
            <xsl:attribute name="style">
               <xsl:value-of select="string(@property)"/>
            </xsl:attribute>
         </xsl:if>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

</xsl:stylesheet>
