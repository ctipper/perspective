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
   <!-- block elements -->
   <!-- =============================================================== -->

   <!-- =============================================================== -->
   <!-- para 

        Condition attribute signifies CSS class
        Property attribute contains align property
     -->
   <!-- =============================================================== -->
   
   <xsl:template match="p">
      <xsl:element name="para">
         <xsl:if test="@class=true()">
            <xsl:attribute name="condition">
               <xsl:value-of select="@class"/>
            </xsl:attribute>
         </xsl:if>
         <xsl:if test="@align=true()">
            <xsl:attribute name="property">
               <xsl:text>text-align: </xsl:text>
               <xsl:value-of select="@align"/><xsl:text>;</xsl:text>
            </xsl:attribute>
         </xsl:if>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

   <xsl:template match="blockquote">
      <xsl:choose>
         <xsl:when test="position()=1 or position()=2">
            <epigraph>
               <xsl:apply-templates/>
            </epigraph>
         </xsl:when>
         <xsl:otherwise>
            <blockquote>
               <xsl:apply-templates/>
            </blockquote>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <xsl:template match="epigraph">
      <epigraph>
         <xsl:apply-templates />
      </epigraph>
   </xsl:template>
   
   <xsl:template match="center">
      <xsl:element name="para">
         <xsl:if test="@class=true()">
            <xsl:attribute name="role">
               <xsl:value-of select="@class"/>
            </xsl:attribute>
         </xsl:if>
         <xsl:attribute name="condition">center</xsl:attribute>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

   <xsl:template match="sub-heading">
      <bridgehead renderas="sect2">
         <xsl:apply-templates/>
      </bridgehead>
   </xsl:template>

   <xsl:template match="byline">
      <para role="byline">
         <xsl:apply-templates/>
      </para>
   </xsl:template>
   
   <xsl:template match="pre">
      <literallayout class="normal">
         <xsl:apply-templates/>
      </literallayout>
   </xsl:template>

   <xsl:template match="section">
      <xsl:element name="section">
         <xsl:if test="@id">
            <xsl:attribute name="xml:id"><xsl:value-of select="@id"/></xsl:attribute>
         </xsl:if>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

   <xsl:template match="blog">
      <xsl:element name="sect1">
         <xsl:attribute name="xml:id"><xsl:value-of select="@id"/></xsl:attribute>
         <xsl:apply-templates select="bloginfo" mode="info"/>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

   <xsl:template match="bloginfo" mode="info">
      <info>
         <xsl:apply-templates select="title"/>
         <xsl:apply-templates select="date"/>
         <xsl:apply-templates select="keywords"/>
      </info>
   </xsl:template>

   <xsl:template match="bloginfo">
   </xsl:template>
   
</xsl:stylesheet> 
