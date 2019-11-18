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
   <!-- meta information -->
   <!-- =============================================================== -->

   <xsl:template match="db:article/db:info">
      <header>
         <xsl:apply-templates select="db:pubdate"/>
         <h1><xsl:apply-templates select="db:title"/></h1>
         <xsl:if test="child::db:subtitle">
            <h3><xsl:apply-templates select="db:subtitle"/></h3>
         </xsl:if>
         <xsl:call-template name="byline"/>
         <hr class="dashed"><xsl:text> </xsl:text></hr>
         <xsl:apply-templates select="db:abstract"/>
         <xsl:if test="(child::db:revhistory) and ($media='screen')">
            <xsl:apply-templates select="db:revhistory"/>
         </xsl:if>
         <xsl:choose>
            <xsl:when test="parent::db:article/descendant::db:sect1">
               <xsl:call-template name="table-of-contents">
                  <xsl:with-param name="section">sect1</xsl:with-param>
               </xsl:call-template>
               <hr class="dashed"><xsl:text> </xsl:text></hr>
            </xsl:when>
            <xsl:when test="parent::db:article/descendant::db:section">
               <xsl:call-template name="table-of-contents">
                  <xsl:with-param name="section">section</xsl:with-param>
               </xsl:call-template>
               <hr class="dashed"><xsl:text> </xsl:text></hr>
            </xsl:when>
         </xsl:choose>
      </header>
   </xsl:template>

   <xsl:template match="db:info/db:title">
      <xsl:choose>
         <xsl:when test="not(parent::db:info/following-sibling::db:sect1/child::db:info)">
            <xsl:element name="a">
               <xsl:attribute name="href">
                  <xsl:value-of select="$site-url"/>
                  <xsl:value-of select="$file-name"/><xsl:text>.html</xsl:text>
               </xsl:attribute>
               <xsl:attribute name="title">
                  <xsl:apply-templates mode="heading"/>
               </xsl:attribute>
               <xsl:attribute name="rel">bookmark</xsl:attribute>
               <xsl:apply-templates/>
            </xsl:element>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="db:info/db:title" mode="header">
      <xsl:apply-templates mode="header"/>
   </xsl:template>

   <xsl:template match="db:info/db:subtitle">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="db:info/db:subtitle" mode="header">
      <xsl:element name="meta">
         <xsl:attribute name="name">description</xsl:attribute>
         <xsl:attribute name="content">
            <xsl:apply-templates mode="header"/>
         </xsl:attribute>
      </xsl:element>
   </xsl:template>

   <xsl:template match="db:info/db:copyright" mode="header">
      <xsl:element name="meta">
         <xsl:attribute name="name">copyright</xsl:attribute>
         <xsl:attribute name="content">
            <xsl:value-of select="db:holder"/>
         </xsl:attribute>
      </xsl:element>
   </xsl:template>

   <xsl:template match="db:info/db:abstract">
      <div class="abstract">
         <div class="blockx">
            <xsl:choose>
               <xsl:when test="name(child::node())='para'">
                  <xsl:apply-templates select="db:para" mode="emptypara"/>
               </xsl:when>
               <xsl:otherwise>
                  <strong>Abstract:</strong><xsl:text> </xsl:text><xsl:apply-templates/>
               </xsl:otherwise>
            </xsl:choose>
         </div>
      </div>
   </xsl:template>

   <xsl:template match="db:abstract/db:para" mode="emptypara">
      <xsl:if test="position()=1">
         <p><strong>Abstract:</strong><xsl:text> </xsl:text><xsl:apply-templates/></p>
      </xsl:if>
      <xsl:if test="position()&gt;1">
         <p><xsl:apply-templates/></p>
      </xsl:if>
   </xsl:template>

   <xsl:template match="db:copyright/db:holder">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="db:firstname">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="db:othername">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="db:surname">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template name="authorname">
      <xsl:value-of select="descendant::db:firstname"/><xsl:text> </xsl:text>
      <xsl:if test="descendant::db:othername">
         <xsl:value-of select="descendant::db:othername"/><xsl:text> </xsl:text>
      </xsl:if>
      <xsl:value-of select="descendant::db:surname"/>
   </xsl:template>

   <xsl:template name="authornames">
      <xsl:element name="meta">
         <xsl:attribute name="name">author</xsl:attribute>
         <xsl:attribute name="content">
            <xsl:for-each select="db:info/db:author">
               <xsl:choose>
                  <xsl:when test="following-sibling::db:author">
                     <xsl:call-template name="authorname"/> and<xsl:text> </xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:call-template name="authorname"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </xsl:attribute>
      </xsl:element>
   </xsl:template>

   <xsl:template match="db:holder">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template name="keywords">
      <xsl:for-each select="db:keyword">
         <xsl:choose>
            <xsl:when test="following-sibling::db:keyword">
               <xsl:value-of select="."/>,<xsl:text> </xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="."/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:for-each>
   </xsl:template>

   <xsl:template match="db:info/db:keywordset" mode="header">
      <xsl:element name="meta">
         <xsl:attribute name="name">keywords</xsl:attribute>
         <xsl:attribute name="content">
            <xsl:call-template name="keywords"/>
         </xsl:attribute>
      </xsl:element>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- 'root' tags -->
   <!-- =============================================================== -->

   <xsl:template match="db:sect1/db:info/db:keywordset | db:sect2/db:info/db:keywordset |
                        db:sect3/db:info/db:keywordset">
      <!-- noop -->
   </xsl:template>

   <xsl:template match="db:article/db:info/db:pubdate | db:sect1/db:info/db:pubdate |
                        db:sect2/db:info/db:pubdate | db:sect3/db:info/db:pubdate">
      <p class="date">
         <xsl:apply-templates/>
      </p>
   </xsl:template>

   <xsl:template match="db:biblioentry/db:pubdate">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="db:abstract/db:title">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template name="byline">
      <xsl:element name="p">
         <xsl:attribute name="class">byline</xsl:attribute>
         <xsl:text>by </xsl:text>
         <xsl:for-each select="db:author">
            <xsl:choose>
               <xsl:when test="following-sibling::db:author">
                  <xsl:call-template name="authorname"/> &amp;<xsl:text> </xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:call-template name="authorname"/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
         <xsl:text> </xsl:text>
         <xsl:apply-templates select="db:author/db:affiliation"/>
      </xsl:element>
   </xsl:template>

   <xsl:template match="db:author/db:affiliation"><xsl:apply-templates/></xsl:template>

   <xsl:template match="db:email">&lt;<a href="mailto:{$email-address}"><xsl:value-of select="$email-address"/></a>&gt;</xsl:template>

   <xsl:template match="db:info/db:copyright/db:year">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="db:info/db:copyright/db:holder">
      <xsl:apply-templates/>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- revision history -->
   <!-- =============================================================== -->

   <xsl:template match="db:revhistory">
      <div class="table-responsive">
         <div style="width: 600px; margin-left: auto; margin-right: auto;" id="revhistory">
            <table class="tabular" style="width: 100%; margin: 0; text-align: left;">
               <colgroup>
                  <col style="width: 16.67%;" />
                  <col style="width: 83.33%;" />
               </colgroup>
               <thead class="revision">
                  <tr>
                     <th colspan="2" class="table-header">Revision History</th>
                  </tr>
               </thead>
               <tbody class="revision">
                  <tr>
                     <td class="table-head">Revision</td>
                     <td class="table-head">Date</td>
                  </tr>
                  <xsl:apply-templates select="db:revision"/>
               </tbody>
            </table>
         </div>
      </div>
   </xsl:template>

   <xsl:template match="db:revision">
      <tr>
         <td class="table-cell"><xsl:apply-templates select="db:revnumber"/></td>
         <td class="table-cell"><xsl:apply-templates select="db:date"/></td>
      </tr>
      <tr>
         <td class="table-cell"><xsl:text> </xsl:text></td>
         <td class="table-cell"><xsl:apply-templates select="db:revremark"/></td>
      </tr>
   </xsl:template>

   <xsl:template match="db:revnumber">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="db:revision/db:date">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="db:revremark">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template name="table-of-contents">
      <xsl:param name="section">sect1</xsl:param>
      <xsl:choose>
         <xsl:when test="string($section)='sect1'">
            <h3>Contents</h3>
            <xsl:for-each select="//db:sect1/descendant-or-self::db:title[1]">
               <p>
                  <xsl:element name="a">
                     <xsl:attribute name="href">
                        <xsl:if test="parent::db:info">
                           <xsl:value-of select="$site-url"/>
                           <xsl:value-of select="$file-name"/><xsl:text>.html</xsl:text>
                        </xsl:if>
                        <xsl:text>#</xsl:text>
                        <xsl:value-of select="ancestor::db:sect1[1]/attribute::xml:id"/>
                     </xsl:attribute>
                     <xsl:apply-templates/>
                  </xsl:element>
               </p>
            </xsl:for-each>
         </xsl:when>
         <xsl:when test="string($section)='section'">
            <h3>Contents</h3>
            <xsl:for-each select="//db:section/descendant-or-self::db:title[1]">
               <p>
                  <xsl:element name="a">
                     <xsl:attribute name="href">
                        <xsl:if test="parent::db:info">
                           <xsl:value-of select="$site-url"/>
                           <xsl:value-of select="$file-name"/><xsl:text>.html</xsl:text>
                        </xsl:if>
                        <xsl:text>#</xsl:text>
                        <xsl:value-of select="ancestor::db:section[1]/attribute::xml:id"/>
                     </xsl:attribute>
                     <xsl:apply-templates/>
                  </xsl:element>
               </p>
            </xsl:for-each>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   
</xsl:stylesheet>
