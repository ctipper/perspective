<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                exclude-result-prefixes="db xlink">

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
   <!--
       handles Uniform Resource Locators (URLs)
       semantics as defined in DocBook 5 schema
     -->
   <!-- =============================================================== -->

   <xsl:template match="db:link">
      <xsl:choose>
         <!-- simple link -->
         <xsl:when test="@linkend=true()">
            <a href="#{@linkend}">
               <xsl:choose>
                  <xsl:when test="child::node()">
                     <xsl:apply-templates/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="@endterm"/>
                  </xsl:otherwise>
               </xsl:choose>
            </a>
         </xsl:when>
         <xsl:otherwise>
            <!-- standard href -->
            <xsl:choose>
               <xsl:when test="@xlink:role=true()">
                  <xsl:choose>
                     <xsl:when test="@xlink:role='button'">
                        <xsl:call-template name="button"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:apply-templates/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:element name="a">
                     <xsl:attribute name="href">
                        <xsl:value-of select="@xlink:href"/>
                     </xsl:attribute>
                     <xsl:if test="@xlink:title=true()">
                        <xsl:attribute name="title">
                           <xsl:value-of select="@xlink:title"/>
                        </xsl:attribute>
                     </xsl:if>
                     <xsl:choose>
                        <xsl:when test="child::node()">
                           <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:when test="@endterm=true()">
                           <xsl:value-of select="@endterm"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="@xlink:href"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:element>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="button">
      <xsl:element name="a">
         <xsl:attribute name="href">
            <xsl:value-of select="@xlink:href"/>
         </xsl:attribute>
         <xsl:if test="@xlink:title=true()">
            <xsl:attribute name="title">
               <xsl:value-of select="@xlink:title"/>
            </xsl:attribute>
         </xsl:if>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- document anchor -->
   <!-- =============================================================== -->

   <xsl:template match="db:anchor">
      <a id="{@xml:id}"><xsl:text> </xsl:text></a>
   </xsl:template>

   <xsl:template match="db:info/db:extendedlink">
      <!-- noop -->
   </xsl:template>

</xsl:stylesheet> 
