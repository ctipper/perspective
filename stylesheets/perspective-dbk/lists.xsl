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

   <xsl:template match="enumerate">
      <xsl:element name="orderedlist">
         <xsl:if test="@style=true()">
            <xsl:attribute name="role">
               <xsl:value-of select="@style"/>
            </xsl:attribute>
         </xsl:if>
         <xsl:attribute name="inheritnum">ignore</xsl:attribute>
         <xsl:attribute name="continuation">restarts</xsl:attribute>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>
   
   <xsl:template match="itemize">
      <itemizedlist>
         <xsl:apply-templates/>
      </itemizedlist>
   </xsl:template>
   
   <xsl:template match="item">
      <listitem>
         <xsl:apply-templates/>
      </listitem>
   </xsl:template>

</xsl:stylesheet>
