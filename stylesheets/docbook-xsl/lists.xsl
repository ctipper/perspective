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
   <!-- handle ordered lists in the form

        <orderedlist>
           <listitem>...</listitem>
           <listitem>...</listitem>
        </orderedlist>

        Condition attribute signifies CSS class
        Role attribute signifies list-style-type
     -->
   <!-- =============================================================== -->

   <xsl:template match="db:orderedlist">
      <xsl:element name="ol">
         <xsl:choose>
            <xsl:when test="@role='a'">
               <xsl:attribute name="style">list-style-type: lower-alpha;</xsl:attribute>
            </xsl:when>
            <xsl:when test="@role='A'">
               <xsl:attribute name="style">list-style-type: upper-alpha;</xsl:attribute>
            </xsl:when>
            <xsl:when test="@role='i'">
               <xsl:attribute name="style">list-style-type: lower-roman;</xsl:attribute>
            </xsl:when>
            <xsl:when test="@role='I'">
               <xsl:attribute name="style">list-style-type: upper-roman;</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="style">list-style-type: decimal;</xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>                
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- handle variable lists in the form

        <variablelist>
           <varlistentry><term>...</term>
              <listitem>...</listitem>
           </varlistentry>
           <varlistentry><term>...</term>
              <listitem>...</listitem>
           </varlistentry>
        </orderedlist>

        Condition attribute signifies CSS class
        <term> contains an attribute to be presented at start of listitem
     -->
   <!-- =============================================================== -->

   <xsl:template match="db:variablelist">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="db:varlistentry">
      <p>
         <xsl:for-each select="db:term">
            <b><xsl:value-of select="."/></b>
            <xsl:if test="position()!=last()">, </xsl:if>
         </xsl:for-each>
      </p>
      <xsl:apply-templates select="db:listitem" mode="no-list"/>
   </xsl:template>

   <xsl:template match="db:term">
   </xsl:template>

   <!-- =============================================================== -->
   <!-- handle bulleted lists in the form

        <itemizedlist>
           <listitem>...</listitem>
           <listitem>...</listitem>
        </itemizedlist>

        The simplified semantics allow for stylesheet specified bullet symbols (don't ask)
        Condition attribute signifies CSS class
     -->
   <!-- =============================================================== -->

   <xsl:template match="db:itemizedlist">
      <ul><xsl:apply-templates/></ul>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- for both types of itemization: listitem -->
   <!-- =============================================================== -->

   <xsl:template match="db:listitem">
      <xsl:choose>
         <xsl:when test="@condition=true()">
            <li>
               <div class="{string(@condition)}">
                  <xsl:apply-templates/>
               </div>
            </li>
         </xsl:when>
         <xsl:otherwise>
            <li><xsl:apply-templates/></li>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <xsl:template match="db:listitem" mode="no-list">
      <xsl:apply-templates/>
   </xsl:template>

</xsl:stylesheet>
