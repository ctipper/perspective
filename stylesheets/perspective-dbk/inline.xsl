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
   <!-- inline elements -->
   <!-- =============================================================== -->

   <xsl:template match="q"><quote><xsl:apply-templates/></quote></xsl:template>

   <xsl:template match="sq">&#x2018;<xsl:apply-templates/>&#x2019;</xsl:template>

   <xsl:template match="apos">&#x2019;</xsl:template>

   <xsl:template match="i"><emphasis><xsl:apply-templates/></emphasis></xsl:template>

   <xsl:template match="b"><emphasis role="bold"><xsl:apply-templates/></emphasis></xsl:template>

   <xsl:template match="u"><emphasis role="underline"><xsl:apply-templates/></emphasis></xsl:template>

   <xsl:template match="sub"><subscript><xsl:apply-templates/></subscript></xsl:template>

   <xsl:template match="sup"><superscript><xsl:apply-templates/></superscript></xsl:template>

   <xsl:template match="tt"><literal><xsl:apply-templates/></literal></xsl:template>

   <xsl:template match="space">&#x00A0;</xsl:template>

   <xsl:template match="hr"><sbr/></xsl:template>

   <xsl:template match="cite">
      <citation>
         <xsl:apply-templates/>
      </citation>
   </xsl:template>

   <xsl:template match="footnote">
      <footnote>
         <xsl:choose>
            <xsl:when test="child::p">
               <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
               <para><xsl:apply-templates/></para>
            </xsl:otherwise>
         </xsl:choose>
      </footnote>
   </xsl:template>

</xsl:stylesheet>
