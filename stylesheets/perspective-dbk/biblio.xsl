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
   <!-- process bibliography -->
   <!-- =============================================================== -->

   <xsl:template name="biblio">
      <xsl:if test="child::bibliography">
         <bibliography>
            <xsl:apply-templates select="bibliography"/>
         </bibliography>
      </xsl:if>
   </xsl:template>

   <xsl:template name="bibliography">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="bibitem">
      <xsl:element name="biblioentry">
         <xsl:attribute name="role"><xsl:value-of select="@type"/></xsl:attribute>
         <xsl:attribute name="xreflabel"><xsl:value-of select="@label"/></xsl:attribute>
         <xsl:apply-templates select="title"/>
         <xsl:apply-templates select="author | editor"/>
         <xsl:call-template name="bib-pubdate"/>
         <xsl:if test="@type = 'book'">
            <xsl:apply-templates select="publisher"/>
         </xsl:if>
         <xsl:if test="@type = 'article'">
            <xsl:apply-templates select="journal"/>
         </xsl:if>
         <xsl:apply-templates select="note"/>
      </xsl:element>
   </xsl:template>

   <xsl:template match="bibitem/title">
      <citetitle>
         <xsl:apply-templates/>
      </citetitle>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- process bibliography author names -->
   <!-- =============================================================== -->

   <xsl:template name="bib-names">
      <xsl:param name="author-names">John Doe and Jane Doe</xsl:param>
      <xsl:param name="author-tag">author</xsl:param>
      <xsl:choose>
         <xsl:when test="contains(string($author-names),' and ')">
            <xsl:element name="{$author-tag}">
               <personname>
                  <xsl:call-template name="bib-surname">
                     <xsl:with-param name="author-surname">
                        <xsl:value-of select="substring-before(string($author-names),' and ')"/>
                     </xsl:with-param>
                     <xsl:with-param name="author-tag"><xsl:value-of select="$author-tag"/></xsl:with-param>
                  </xsl:call-template>
               </personname>
            </xsl:element>
            <xsl:call-template name="bib-names">
               <xsl:with-param name="author-names">
                  <xsl:value-of select="substring-after(string($author-names),' and ')"/>
               </xsl:with-param>
               <xsl:with-param name="author-tag"><xsl:value-of select="$author-tag"/></xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$author-tag}">
               <personname>
                  <xsl:call-template name="bib-surname">
                     <xsl:with-param name="author-surname">
                        <xsl:value-of select="string($author-names)"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </personname>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="bib-surname">
      <xsl:param name="author-surname">John Doe</xsl:param>
      <xsl:param name="middle-name" select="''"/>
      <xsl:param name="tag-name">firstname</xsl:param>
      <xsl:choose>
         <xsl:when test="$tag-name='firstname' and not(contains(string($author-surname),' '))">
            <surname>
               <xsl:value-of select="string($author-surname)"/>
            </surname>
         </xsl:when>
         <xsl:when test="$tag-name='firstname'">
            <firstname>
               <xsl:value-of select="substring-before(string($author-surname),' ')"/>
            </firstname>
            <xsl:call-template name="bib-surname">
               <xsl:with-param name="author-surname">
                  <xsl:value-of select="substring-after(string($author-surname),' ')"/>
               </xsl:with-param>
               <xsl:with-param name="tag-name">othername</xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <!-- following collects middle names/initials for output before surname -->
         <xsl:when test="$tag-name='othername' and contains(string($author-surname),' ')">
            <xsl:call-template name="bib-surname">
               <xsl:with-param name="author-surname">
                  <xsl:value-of select="substring-after(string($author-surname),' ')"/>
               </xsl:with-param>
               <xsl:with-param name="middle-name">
                  <xsl:value-of select="$middle-name"/>
                  <xsl:value-of select="substring-before(string($author-surname),' ')"/>
                  <xsl:if test="contains(substring-after(string($author-surname),' '),' ')"><xsl:text> </xsl:text></xsl:if>
               </xsl:with-param>
               <xsl:with-param name="tag-name">othername</xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <xsl:when test="not(contains(string($author-surname),' '))">
            <xsl:if test="$middle-name != ''">
               <othername>
                  <xsl:value-of select="$middle-name"/>
               </othername>
            </xsl:if>
            <surname>
               <xsl:value-of select="string($author-surname)"/>
            </surname>
         </xsl:when>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="bibitem/author | bibitem/editor">
      <xsl:choose>
         <xsl:when test="contains(string(.),' and ')">
            <xsl:call-template name="bib-names">
               <xsl:with-param name="author-tag"><xsl:value-of select="name(.)"/></xsl:with-param>
               <xsl:with-param name="author-names"><xsl:apply-templates/></xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{name(.)}">
               <personname>
                  <xsl:call-template name="bib-surname">
                     <xsl:with-param name="author-surname"><xsl:apply-templates/></xsl:with-param>
                  </xsl:call-template>
               </personname>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="bib-pubdate">
      <pubdate>
         <xsl:choose>
            <xsl:when test="child::month">
               <xsl:value-of select="month"/>,<xsl:text> </xsl:text>
               <xsl:value-of select="year"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="year"/>
            </xsl:otherwise>
         </xsl:choose>
      </pubdate>
   </xsl:template>
   
   <xsl:template match="bibitem/publisher | bibitem/journal">
      <publisher>
         <publishername><xsl:apply-templates/></publishername>
      </publisher>
   </xsl:template>

   <xsl:template match="bibitem/note">
      <bibliomisc role="note"><xsl:apply-templates/></bibliomisc>
   </xsl:template>

</xsl:stylesheet> 
