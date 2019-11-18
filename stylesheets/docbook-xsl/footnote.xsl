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
   <!-- 
        Following automatically handles footnote numbering and transformation to endnotes.
        Table numbering is a special case.

        A schematic representation of the footnote template collection:
        
        <xsl:template match="footnote">
           <xsl:text> </xsl:text>
           <a name="backref-xx"></a>
           [<a href="footnote-xx">
              <xsl:number level="any" count="footnote"/>
           </a>]
           <xsl:text> </xsl:text>
        </xsl:template>
        
        <xsl:template match="footnote" mode="endnotes">
           <p>
              <a name="footnote-xx"></a>
              [<a href="backref-xx">
                 <xsl:number level="any" count="footnote"/>
              </a>]
              <xsl:text> </xsl:text>
              <xsl:apply-templates/>
           </p>
        </xsl:template>
     -->            
   <!-- =============================================================== -->

   <!-- =============================================================== -->
   <!-- auxiliary templates for footnotes -->
   <!-- =============================================================== -->

   <xsl:template name="backrefname">
      <a id="brf.{generate-id(.)}">
         <xsl:text> </xsl:text>
      </a>
   </xsl:template>

   <xsl:template name="backrefhref">
      <xsl:param name="footnote-no">01</xsl:param>
      <a href="#brf.{generate-id(parent::db:footnote)}">
         <xsl:value-of select="$footnote-no"/>
      </a>
   </xsl:template>

   <!-- footnotename not used here --> 
   <xsl:template name="footnotename">
      <a id="ftn.{generate-id(parent::db:footnote)}">
         <xsl:text> </xsl:text>
      </a>
   </xsl:template>

   <xsl:template name="footnotehref">
      <xsl:param name="footnote-no">01</xsl:param>
      <a href="#ftn.{generate-id(.)}">
         <xsl:value-of select="$footnote-no"/>
      </a>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- Produce "Endnotes" heading at start of block -->
   <!-- =============================================================== -->

   <xsl:template name="endnotes">
      <xsl:param name="footnote-no">01</xsl:param>
      <xsl:if test="$footnote-no='1'"><h2>Endnotes:</h2></xsl:if>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- generate footnote reference -->
   <!-- =============================================================== -->

   <xsl:template match="db:para/db:footnote | db:entry/db:footnote">
      <xsl:text> </xsl:text>
      <xsl:call-template name="backrefname"/>
      <xsl:text>[</xsl:text>
      <xsl:call-template name="footnotehref">
         <xsl:with-param name="footnote-no">
            <xsl:if test="parent::db:para">
               <xsl:number level="any" count="db:para/db:footnote" format="1"/>
            </xsl:if>
            <xsl:if test="parent::db:entry">
               <xsl:number level="any" count="db:entry/db:footnote" from="table" format="a"/>
            </xsl:if>
         </xsl:with-param>
      </xsl:call-template>
      <xsl:text>] </xsl:text>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- generate endnotes -->
   <!-- =============================================================== -->

   <xsl:template match="db:para/db:footnote | db:entry/db:footnote" mode="endnotes">
      <xsl:if test="parent::db:para">
         <xsl:call-template name="endnotes">
            <xsl:with-param name="footnote-no">
               <xsl:number level="any" count="db:para/db:footnote" format="1"/>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:if>
      <xsl:apply-templates select="db:para" mode="endnotes"/>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- para: note that DocBook expects footnote/para -->
   <!-- =============================================================== -->

   <xsl:template match="db:para" mode="endnotes">
      <xsl:element name="p">    
         <xsl:if test="ancestor::db:entry">
            <xsl:attribute name="class">small</xsl:attribute>
         </xsl:if>
         <xsl:if test="position()=1">
            <a id="ftn.{generate-id(parent::db:footnote)}"><xsl:text> </xsl:text></a>
            <xsl:text>[</xsl:text>
            <xsl:call-template name="backrefhref">
               <xsl:with-param name="footnote-no">
                  <xsl:if test="ancestor::db:para">
                     <xsl:number level="any" count="db:para/db:footnote" format="1"/>
                  </xsl:if>
                  <xsl:if test="ancestor::db:entry">
                     <xsl:number level="any" count="db:entry/db:footnote" from="table" format="a"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:text>] </xsl:text>
         </xsl:if>
         <xsl:apply-templates/>
         <xsl:if test="(position()=last()) and ($media='screen') and not(ancestor::db:entry)">
            <xsl:text> </xsl:text>
            <a href="#brf.{generate-id(parent::db:footnote)}" title="Back">
               <xsl:text> </xsl:text>
            </a>
         </xsl:if>
      </xsl:element>
   </xsl:template>

</xsl:stylesheet>
