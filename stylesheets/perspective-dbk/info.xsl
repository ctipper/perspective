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
   <!-- 'root' tags -->
   <!-- =============================================================== -->

   <xsl:template name="info">
      <info>
         <xsl:apply-templates select="info/title"/>
         <xsl:apply-templates select="info/subtitle"/>
         <xsl:apply-templates select="info/introduction"/>     <!-- abstract -->
         <xsl:apply-templates select="info/author"/>
         <xsl:apply-templates select="info/date"/>
         <xsl:apply-templates select="info/copyright"/>
         <xsl:apply-templates select="info/keywords"/>
         <xsl:apply-templates select="info/revhistory"/>
      </info>
   </xsl:template>

   <xsl:template match="title">
      <xsl:choose>
         <xsl:when test="not(normalize-space(.))">
            <title><xsl:text> </xsl:text></title>
         </xsl:when>
         <xsl:otherwise>
            <title><xsl:apply-templates/></title>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="info/subtitle">
      <subtitle><xsl:apply-templates/></subtitle>
   </xsl:template>

   <xsl:template match="info/introduction">
      <abstract><xsl:apply-templates/></abstract>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- article publication date -->
   <!-- =============================================================== -->
   
   <xsl:template match="date">
      <pubdate><xsl:apply-templates/></pubdate>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- process copyright year and name -->
   <!-- =============================================================== -->

   <xsl:template match="info/copyright">
      <copyright>
         <year><xsl:value-of select="child::year"/></year>
         <holder><xsl:value-of select="child::owner"/></holder>
      </copyright>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- process document author names -->
   <!-- =============================================================== -->

   <xsl:template match="info/author">
      <xsl:choose>
         <xsl:when test="contains(string(.),' and ')">
            <xsl:call-template name="info-names">
               <xsl:with-param name="author-names"><xsl:value-of select="."/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="author">
               <personname>
                  <xsl:call-template name="current-surname">
                     <xsl:with-param name="author-surname">
                        <xsl:value-of select="."/>
                     </xsl:with-param>
                  </xsl:call-template>
               </personname>
               <affiliation>
                  <address>
                     <email><xsl:value-of select="$email-address"/></email>
                  </address>
               </affiliation>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="info-names">
      <xsl:param name="author-names">John Doe and Jane Doe</xsl:param>
      <xsl:param name="author-tag">author</xsl:param>
      <xsl:choose>
         <xsl:when test="contains(string($author-names),' and ')">
            <xsl:element name="{$author-tag}">
               <personname>
                  <xsl:call-template name="current-surname">
                     <xsl:with-param name="author-surname">
                        <xsl:value-of select="substring-before(string($author-names),' and ')"/>
                     </xsl:with-param>
                     <xsl:with-param name="author-tag"><xsl:value-of select="$author-tag"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </personname>
            </xsl:element>
            <xsl:call-template name="info-names">
               <xsl:with-param name="author-names">
                  <xsl:value-of select="substring-after(string($author-names),' and ')"/>
               </xsl:with-param>
               <xsl:with-param name="author-tag"><xsl:value-of select="$author-tag"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$author-tag}">
               <personname>
                  <xsl:call-template name="current-surname">
                     <xsl:with-param name="author-surname">
                        <xsl:value-of select="string($author-names)"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </personname>
               <affiliation>
                  <address>
                     <email><xsl:value-of select="$email-address"/></email>
                  </address>
               </affiliation>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="current-surname">
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
            <xsl:call-template name="current-surname">
               <xsl:with-param name="author-surname">
                  <xsl:value-of select="substring-after(string($author-surname),' ')"/>
               </xsl:with-param>
               <xsl:with-param name="tag-name">othername</xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <!-- following collects middle names/initials for output before surname -->
         <xsl:when test="$tag-name='othername' and contains(string($author-surname),' ')">
            <xsl:call-template name="current-surname">
               <xsl:with-param name="author-surname">
                  <xsl:value-of select="substring-after(string($author-surname),' ')"/>
               </xsl:with-param>
               <xsl:with-param name="middle-name">
                  <xsl:value-of select="$middle-name"/>
                  <xsl:value-of select="substring-before(string($author-surname),' ')"/>
                  <xsl:if test="contains(substring-after(string($author-surname),' '),' ')">
                     <xsl:text> </xsl:text>
                  </xsl:if>
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

   <!-- =============================================================== -->
   <!-- process keywords -->
   <!-- =============================================================== -->

   <xsl:template match="keywords">
      <xsl:element name="keywordset">
         <xsl:call-template name="keyword">
            <xsl:with-param name="keyword-names"><xsl:value-of select="."/>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>

   <xsl:template name="keyword">
      <xsl:param name="keyword-names">keywords here, more keywords</xsl:param>
      <xsl:choose>
         <xsl:when test="contains($keyword-names,',')">
            <xsl:element name="keyword">
               <xsl:choose>
                  <xsl:when test="substring($keyword-names,1,1)=' '">
                     <xsl:value-of select="
                                           substring-before(
                                           substring-after($keyword-names,' '),
                                           ',')"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="substring-before($keyword-names,',')"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:element>
            <xsl:call-template name="keyword">
               <xsl:with-param name="keyword-names">
                  <xsl:value-of select="substring-after($keyword-names,',')"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="keyword">
               <xsl:choose>
                  <xsl:when test="substring($keyword-names,1,1)=' '">
                     <xsl:value-of select="substring-after($keyword-names,' ')"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="$keyword-names"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- handle revisions -->
   <!-- =============================================================== -->

   <xsl:template match="info/revhistory">
      <revhistory>
         <xsl:apply-templates/>
      </revhistory>
   </xsl:template>

   <xsl:template match="revision">
      <revision>
         <xsl:apply-templates/>
      </revision>
   </xsl:template>

   <xsl:template match="revnumber">
      <revnumber><xsl:apply-templates/></revnumber>
   </xsl:template>

   <xsl:template match="revdate">
      <date><xsl:apply-templates/></date>
   </xsl:template>

   <xsl:template match="revremark">
      <revremark><xsl:apply-templates/></revremark>
   </xsl:template>

</xsl:stylesheet>
