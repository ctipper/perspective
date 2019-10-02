<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://docbook.org/ns/docbook">

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
   <!-- 
       - computes image sizes depending on $resolution parameter
       - a basic viewport is created based on the @space parameter 
       i.e. a blank border around the image
       - filename is partially reconstructed using the @format attribute
     -->
   <!-- =============================================================== -->

   <xsl:template match="img">
      <mediaobject>
         <alt><xsl:value-of select="@alt"/></alt>
         <imageobject>
            <xsl:element name="imagedata">
               <xsl:attribute name="fileref">
                  <xsl:value-of select="@src"/>.<xsl:value-of select="translate(string(@format),
                                'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                                'abcdefghijklmnopqrstuvwxyz')" />
               </xsl:attribute>
               <xsl:attribute name="format">
                  <xsl:value-of select="translate(string(@format),
                               'abcdefghijklmnopqrstuvwxyz',
                               'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
               </xsl:attribute>
               <xsl:attribute name="contentwidth"><xsl:value-of select="format-number(@width * (2.54 div $resolution),'0.000')"/>cm</xsl:attribute>
               <xsl:attribute name="contentdepth"><xsl:value-of select="format-number(@height * (2.54 div $resolution),'0.000')"/>cm</xsl:attribute>
               <xsl:attribute name="width"><xsl:value-of select="format-number((@width + (@space * 2)) * (2.54 div $resolution),'0.000')"/>cm</xsl:attribute>
               <xsl:attribute name="depth"><xsl:value-of select="format-number((@height + (@space * 2)) * (2.54 div $resolution),'0.000')"/>cm</xsl:attribute>
               <xsl:if test="@align=true()">
                  <xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
               </xsl:if>
               <xsl:if test="@pdfres=true()">
                  <xsl:attribute name="role"><xsl:value-of select="@pdfres"/></xsl:attribute>
               </xsl:if>
            </xsl:element>
         </imageobject>
         <xsl:apply-templates/>
      </mediaobject>
   </xsl:template>

   <xsl:template match="img/caption">
      <xsl:element name="caption">
         <xsl:if test="@figure='yes'">
            <xsl:attribute name="role">figure</xsl:attribute>
         </xsl:if>
         <para><xsl:apply-templates/></para>
      </xsl:element>
   </xsl:template>

   <xsl:template match="stop">
      <inlinemediaobject>
         <alt>Stop</alt>
         <imageobject>
            <imagedata fileref="svg/full-stop.svg"/>
         </imageobject>
      </inlinemediaobject>
   </xsl:template>

</xsl:stylesheet>
