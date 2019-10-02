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
   <!-- table or informal table dependent on label present -->
   <!-- =============================================================== -->

   <xsl:template match="table">
      <xsl:choose>
         <xsl:when test="child::label">
            <xsl:element name="table">
               <xsl:if test="@align=true()">
                  <xsl:attribute name="condition"><xsl:value-of select="@align"/></xsl:attribute>
               </xsl:if>
               <xsl:apply-templates select="label"/>
               <xsl:apply-templates select="tgroup"/>
            </xsl:element>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="informaltable">
               <xsl:if test="@align=true()">
                  <xsl:attribute name="condition"><xsl:value-of select="@align"/></xsl:attribute>
               </xsl:if>
               <xsl:apply-templates select="tgroup"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="label">
      <xsl:element name="title">
         <xsl:if test="@number='yes'">
            <xsl:attribute name="role">number</xsl:attribute>
         </xsl:if>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

   <xsl:template match="tgroup">
      <xsl:element name="tgroup">
         <xsl:attribute name="cols">
            <xsl:value-of select="@cols"/>
         </xsl:attribute>
         <xsl:apply-templates select="columns"/>
         <xsl:apply-templates select="//column[@span]" mode="spanspec"/>
         <xsl:apply-templates select="thead"/>
         <xsl:apply-templates select="tfoot"/>
         <xsl:apply-templates select="tbody"/>
      </xsl:element>
   </xsl:template>

   <xsl:template match="columns">
      <xsl:element name="colspec">
         <xsl:attribute name="colnum"><xsl:value-of select="@number"/></xsl:attribute>
         <xsl:attribute name="colwidth"><xsl:value-of select="format-number(@width * (2.54 div $resolution),'0.000')"/>cm</xsl:attribute>
         <xsl:if test="@align=true()">
            <xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
         </xsl:if>
         <xsl:attribute name="colname">column-<xsl:number level="single" count="columns" format="01"/></xsl:attribute>
      </xsl:element>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- 
       Generate CALS model spanspec with unique id for each span 
       <spanspec spanname="id" namest="left-column" nameend="right-column"/> 
     -->
   <!-- =============================================================== -->

   <xsl:template match="row/column[@span]" mode="spanspec">
      <xsl:element name="spanspec">
         <xsl:attribute name="spanname">spn.<xsl:value-of select="generate-id(.)"/></xsl:attribute>
         <xsl:attribute name="namest">column-<xsl:number count="column" from="row" format="01"/></xsl:attribute>
         <xsl:variable name="span_start"><xsl:number count="column" from="row" format="1"/></xsl:variable>
         <xsl:attribute name="nameend">column-<xsl:number value="number($span_start)+number(@span)-1" format="01"/></xsl:attribute>
      </xsl:element>
   </xsl:template>
   
   <xsl:template match="thead">
      <thead>
         <xsl:apply-templates/>
      </thead>
   </xsl:template>

   <xsl:template match="tfoot">
      <tfoot>
         <xsl:apply-templates/>
      </tfoot>
   </xsl:template>

   <xsl:template match="tbody">
      <tbody>
         <xsl:apply-templates/>
      </tbody>
   </xsl:template>

   <xsl:template match="row">
      <xsl:element name="row">
         <xsl:if test="@valign">
            <xsl:attribute name="valign"><xsl:value-of select="@valign"/></xsl:attribute>
         </xsl:if>
         <xsl:apply-templates select="column"/>
      </xsl:element>
   </xsl:template>

   <xsl:template match="column">
      <xsl:element name="entry">
         <xsl:if test="@class=true()">
            <xsl:attribute name="condition"><xsl:value-of select="@class"/></xsl:attribute>
         </xsl:if>
         <xsl:if test="@align=true()">
            <xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
         </xsl:if>
         <xsl:if test="@span=true()">
            <xsl:attribute name="spanname">spn.<xsl:value-of select="generate-id(.)"/></xsl:attribute>
         </xsl:if>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

</xsl:stylesheet>
