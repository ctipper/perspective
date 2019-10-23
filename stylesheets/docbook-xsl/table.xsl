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
   <!-- table handling -->
   <!-- =============================================================== -->

   <!-- =============================================================== 
        TODO: status of the repeated attribute is uncertain with respect
        to DocBook DTD
        =============================================================== -->

   <xsl:template match="db:table | db:informaltable">
      <xsl:choose>
         <xsl:when test="@condition='center'">
            <xsl:element name="div">
               <xsl:attribute name="style">
                  <xsl:text>width: </xsl:text>
                  <xsl:variable name="table_width">
                     <xsl:apply-templates select="descendant::db:tgroup/db:colspec" mode="sum"/>
                  </xsl:variable>
                  <xsl:variable name="actual_width">
                     <xsl:value-of select="format-number(number($table_width) * ($resolution div 2.54),'0')"/>
                  </xsl:variable>
                  <xsl:value-of select="$actual_width"/><xsl:text>px;</xsl:text>
                  <xsl:text> margin-left: auto; margin-right: auto;</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="db:title"/>
               <table class="table">
                  <xsl:apply-templates select="db:tgroup"/>
               </table>
            </xsl:element>
         </xsl:when>
         <xsl:when test="@condition=false()">
            <div class="table-responsive">
               <xsl:apply-templates select="db:title"/>
               <xsl:element name="table">
                  <xsl:attribute name="class">table</xsl:attribute>
                  <xsl:attribute name="style">width: <xsl:variable name="table_width"><xsl:apply-templates select="descendant::db:tgroup/db:colspec" mode="sum"/></xsl:variable><xsl:variable name="actual_width"><xsl:value-of select="format-number(number($table_width) * ($resolution div 2.54),'0')"/></xsl:variable><xsl:value-of select="$actual_width"/>px;</xsl:attribute>
                  <xsl:apply-templates select="db:tgroup"/>
               </xsl:element>
            </div>
         </xsl:when>
         <xsl:otherwise>
            <div style="float: {@condition}; padding: 0px 10px;">
               <xsl:apply-templates select="db:title"/>
               <table class="table">
                  <xsl:apply-templates select="db:tgroup"/>
               </table>
            </div>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="db:tgroup/db:colspec" mode="sum">
      <xsl:param name="col_total" select="0"/>
      <xsl:param name="print" select="1"/>
      <xsl:if test="following-sibling::db:colspec">
         <xsl:apply-templates select="following-sibling::db:colspec" mode="sum">
            <xsl:with-param name="col_total">
               <xsl:value-of select="number($col_total) + number(substring-before(@colwidth,'cm'))"/>
            </xsl:with-param>
            <xsl:with-param name="print">
               <xsl:value-of select="number($print)+1"/>
            </xsl:with-param>
         </xsl:apply-templates>
      </xsl:if>
      <xsl:if test="number($print)=count(parent::db:tgroup/db:colspec)">
         <xsl:value-of select="number($col_total) + number(substring-before(@colwidth,'cm'))"/>
      </xsl:if>
   </xsl:template>      

   <xsl:template match="db:table/db:title">
      <xsl:element name="p">
         <xsl:attribute name="class">caption</xsl:attribute>
         <xsl:attribute name="style">width: <xsl:variable name="table_width"><xsl:apply-templates select="following-sibling::db:tgroup/db:colspec" mode="sum"/></xsl:variable><xsl:variable name="actual_width"><xsl:value-of select="format-number(number($table_width) * ($resolution div 2.54),'0')"/></xsl:variable><xsl:value-of select="$actual_width"/>px;</xsl:attribute>
         <xsl:if test="@role='number'">
            <b>Table <xsl:number level="any" count="//db:table/db:title[@role='number']" format="1"/></b>
            <xsl:text> </xsl:text>
         </xsl:if>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- cols attribute should comply with colspec declarations -->
   <!-- =============================================================== -->

   <xsl:template name="extra-cols">
      <xsl:param name="count">0</xsl:param>
      <xsl:if test="$count > 0">
         <col/>
         <xsl:call-template name="extra-cols">
            <xsl:with-param name="count">
               <xsl:value-of select="$count - 1"/>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>
   
   <xsl:template match="db:tgroup">
      <colgroup>
         <xsl:apply-templates select="db:colspec"/>
         <xsl:variable name="num_cols"><xsl:value-of select="@cols"/></xsl:variable>
         <xsl:variable name="actual_cols"><xsl:value-of select="count(db:colspec)"/></xsl:variable>
         <xsl:if test="$actual_cols  &lt; $num_cols">
            <xsl:call-template name="extra-cols">
               <xsl:with-param name="count">
                  <xsl:value-of select="$num_cols - $actual_cols"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </colgroup>
      <xsl:apply-templates select="db:thead"/>
      <xsl:choose>
         <xsl:when test="child::node()/db:row/db:entry/db:footnote">
            <tfoot>
               <xsl:choose>
                  <xsl:when test="child::db:tfoot">
                     <xsl:call-template name="tfooter"/>
                     <xsl:apply-templates select="db:tfoot"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:call-template name="tfooter"/>
                  </xsl:otherwise>
               </xsl:choose>
            </tfoot>
         </xsl:when>
         <xsl:when test="(child::db:tfoot) and not(child::node()/db:row/db:entry/db:footnote)">
            <tfoot>
               <xsl:apply-templates select="db:tfoot"/>
            </tfoot>
         </xsl:when>
      </xsl:choose>
      <xsl:apply-templates select="db:tbody"/>
   </xsl:template>

   <xsl:template match="db:colspec">
      <xsl:element name="col">
         <xsl:attribute name="style">
            <xsl:text>width: </xsl:text>
            <xsl:value-of select="format-number(number(substring-before(@colwidth,'cm')) * ($resolution div 2.54),'0')"/>
            <xsl:text>px;</xsl:text>
         </xsl:attribute>
         <!-- TODO: colspec[@repeated] is not defined by DocBook DTD, yet is supported in HTML -->
         <!--
             <xsl:if test="@repeated=true()">
                <xsl:attribute name="span"><xsl:value-of select="@repeated"/></xsl:attribute>
             </xsl:if>
         -->
         <!-- The align attribute on the HTML5 col element is obsolete. Use CSS instead. -->
         <!--
         <xsl:if test="@align=true()">
            <xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
         </xsl:if>
         -->
      </xsl:element>
   </xsl:template>

   <xsl:template match="db:thead | db:tbody">
      <xsl:element name="{name(.)}">
         <xsl:choose>
            <xsl:when test="name(.)='thead'">
               <xsl:attribute name="class">theader</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="class">tbody</xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:apply-templates select="db:row"/>
      </xsl:element>
   </xsl:template>

   <xsl:template name="tfooter">
      <tr>
         <td colspan="{@cols}" style="padding: 2px 3px; text-align: left;">
            <xsl:apply-templates select="child::node()/db:row/db:entry/db:footnote" mode="endnotes"/>
         </td>
      </tr>
   </xsl:template>
   
   <xsl:template match="db:tfoot">
      <xsl:apply-templates select="db:row"/>
   </xsl:template>

   <xsl:template match="db:thead/db:row | db:tfoot/db:row">
      <xsl:element name="tr">
         <xsl:choose>
            <xsl:when test="name(parent::node())='thead'">
               <xsl:attribute name="class">thead</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="class">tfoot</xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:apply-templates select="db:entry"/>
         <xsl:variable name="num_cols"><xsl:value-of select="ancestor::db:tgroup/attribute::cols"/></xsl:variable>
         <xsl:variable name="actual_cols"><xsl:value-of select="count(ancestor::db:tgroup/db:colspec)"/></xsl:variable>
         <xsl:if test="$actual_cols  &lt; $num_cols">
            <xsl:call-template name="extra-entries">
               <xsl:with-param name="count">
                  <xsl:value-of select="$num_cols - $actual_cols"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:element>
   </xsl:template>

   <xsl:template match="db:tbody/db:row">
      <xsl:variable name="entry_position">0</xsl:variable>
      <xsl:if test="position() mod 2">
         <xsl:call-template name="odd-row"/>
      </xsl:if>
      <xsl:if test="not(position() mod 2)">
         <xsl:call-template name="even-row"/>
      </xsl:if>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- fill-in undeclared entries -->
   <!-- =============================================================== -->

   <xsl:template name="extra-entries">
      <xsl:param name="count">0</xsl:param>
      <xsl:if test="$count > 0">
         <td class="auto-generated"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></td>
         <xsl:call-template name="extra-entries">
            <xsl:with-param name="count">
               <xsl:value-of select="$count - 1"/>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>
   
   <xsl:template name="odd-row">
      <tr class="odd">
         <xsl:apply-templates select="db:entry"/>
         <xsl:variable name="num_cols"><xsl:value-of select="ancestor::db:tgroup/attribute::cols"/></xsl:variable>
         <xsl:variable name="actual_cols"><xsl:value-of select="count(ancestor::db:tgroup/db:colspec)"/></xsl:variable>
         <xsl:if test="$actual_cols  &lt; $num_cols">
            <xsl:call-template name="extra-entries">
               <xsl:with-param name="count">
                  <xsl:value-of select="$num_cols - $actual_cols"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </tr>
   </xsl:template>

   <xsl:template name="even-row">
      <tr class="even">
         <xsl:apply-templates select="db:entry"/>
         <xsl:variable name="num_cols"><xsl:value-of select="ancestor::db:tgroup/attribute::cols"/></xsl:variable>
         <xsl:variable name="actual_cols"><xsl:value-of select="count(ancestor::db:tgroup/db:colspec)"/></xsl:variable>
         <xsl:if test="$actual_cols  &lt; $num_cols">
            <xsl:call-template name="extra-entries">
               <xsl:with-param name="count">
                  <xsl:value-of select="$num_cols - $actual_cols"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </tr>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- 
        Currently there is no proper account taken of column spans in the alignment code. 
        Attempts to resolve this issue have hit deficiencies in XSLT 1.0. 
        We need a running column-count and I know no way of updating a variable.
        An alternative method using recursive calls to a parameter template found that 
        position() was a global variable and testing recursively produced a stack overflow.
     -->
   <!-- =============================================================== -->

   <xsl:template match="db:tbody/db:row/db:entry | db:tfoot/db:row/db:entry">
      <xsl:element name="td">
         <xsl:if test="@condition=true()">
            <xsl:attribute name="class">
               <xsl:value-of select="@condition"/>
            </xsl:attribute>
         </xsl:if>
         <xsl:attribute name="style"><!-- <xsl:text>padding: 2px 3px;</xsl:text> -->
         <!-- following ensures all entries have an alignment attribute, following a well-known flaw in
              the mozilla browser "Bug 915 - column alignment resolution for <col align> not implemented 
              (text-align, vertical-align styles on columns) [CASCADE]" -->
         <xsl:choose>
            <xsl:when test="@align=true()">
               <xsl:text>text-align: </xsl:text><xsl:value-of select="@align"/><xsl:text>;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <!-- position() by itself is not sufficient for some obscure reason: suspect bug in msxml 4.0 -->
               <xsl:variable name="entry_position"><xsl:value-of select="position()"/></xsl:variable>
               <xsl:text>text-align: </xsl:text><xsl:value-of select="ancestor::db:tgroup/child::db:colspec[$entry_position + 0 - 0]/attribute::align"/><xsl:text>;</xsl:text>
            </xsl:otherwise>
         </xsl:choose>
         </xsl:attribute>
         <xsl:if test="@spanname=true()">
            <xsl:variable name="spname">
               <xsl:value-of select="@spanname"/>
            </xsl:variable>
            <xsl:variable name="first_col">
               <xsl:value-of select="ancestor::db:tgroup/db:spanspec[@spanname=$spname]/attribute::namest"/>
            </xsl:variable>
            <xsl:variable name="last_col">
               <xsl:value-of select="ancestor::db:tgroup/db:spanspec[@spanname=$spname]/attribute::nameend"/>
            </xsl:variable>
            <xsl:variable name="lcol_num">
               <xsl:value-of select="ancestor::db:tgroup/db:colspec[@colname=$first_col]/attribute::colnum"/>
            </xsl:variable>
            <xsl:variable name="rcol_num">
               <xsl:value-of select="ancestor::db:tgroup/db:colspec[@colname=$last_col]/attribute::colnum"/>
            </xsl:variable>
            <xsl:attribute name="colspan"><xsl:value-of select="$rcol_num - $lcol_num + 1"/></xsl:attribute>
         </xsl:if>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

   <xsl:template match="db:thead/db:row/db:entry">
      <xsl:element name="th">
         <xsl:if test="@condition=true()">
            <xsl:attribute name="class">
               <xsl:value-of select="@condition"/>
            </xsl:attribute>
         </xsl:if>
         <xsl:attribute name="style"><!-- <xsl:text>padding: 2px 3px;</xsl:text> -->
         <!-- following ensures all entries have an alignment attribute, following a well-known flaw in
              the mozilla browser "Bug 915 - column alignment resolution for <col align> not implemented 
              (text-align, vertical-align styles on columns) [CASCADE]" -->
         <xsl:choose>
            <xsl:when test="@align=true()">
               <xsl:text>text-align: </xsl:text><xsl:value-of select="@align"/><xsl:text>;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <!-- position() by itself is not sufficient for some obscure reason: suspect bug in msxml 4.0 -->
               <xsl:variable name="entry_position"><xsl:value-of select="position()"/></xsl:variable>
               <xsl:text>text-align: </xsl:text><xsl:value-of select="ancestor::db:tgroup/child::db:colspec[$entry_position + 0 - 0]/attribute::align"/><xsl:text>;</xsl:text>
            </xsl:otherwise>
         </xsl:choose>
         </xsl:attribute>
         <xsl:if test="@spanname=true()">
            <xsl:variable name="spname">
               <xsl:value-of select="@spanname"/>
            </xsl:variable>
            <xsl:variable name="first_col">
               <xsl:value-of select="ancestor::db:tgroup/db:spanspec[@spanname=$spname]/attribute::namest"/>
            </xsl:variable>
            <xsl:variable name="last_col">
               <xsl:value-of select="ancestor::db:tgroup/db:spanspec[@spanname=$spname]/attribute::nameend"/>
            </xsl:variable>
            <xsl:variable name="lcol_num">
               <xsl:value-of select="ancestor::db:tgroup/db:colspec[@colname=$first_col]/attribute::colnum"/>
            </xsl:variable>
            <xsl:variable name="rcol_num">
               <xsl:value-of select="ancestor::db:tgroup/db:colspec[@colname=$last_col]/attribute::colnum"/>
            </xsl:variable>
            <xsl:attribute name="colspan"><xsl:value-of select="$rcol_num - $lcol_num + 1"/></xsl:attribute>
         </xsl:if>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

</xsl:stylesheet>
