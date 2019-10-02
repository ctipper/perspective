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
        Handle LaTeX style bibliography entries 
        
        syntax is <citation>label</citation>                             (i)
        
        and then the bibliography database is a simple enumeration
        
        <bibliography>
           <biblioentry xreflabel="label">...</biblioentry>              (ii)
           <biblioentry xreflabel="another-label">...</biblioentry>
           ...
        </bibliography>
        
        It is up to the document author to reconcile labels in cases (i) and (ii)
        -->
   <!-- =============================================================== -->

   <xsl:template match="db:bibliography">
      <h2>Bibliography</h2>
      <xsl:apply-templates/>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- creates an inline citation -->
   <!-- =============================================================== -->

   <xsl:template match="db:citation">
      <xsl:variable name="citeref" select="."/>
      <xsl:text>(</xsl:text>
      <a href="#{string(.)}">
         <xsl:choose>
            <xsl:when test="//db:bibliography/db:biblioentry[@xreflabel=$citeref]/db:editor/db:personname/db:surname">
               <xsl:value-of select="//db:bibliography/db:biblioentry[@xreflabel=$citeref]/db:editor/db:personname/db:surname"/>, 
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="//db:bibliography/db:biblioentry[@xreflabel=$citeref]/db:author/db:personname/db:surname"/>, 
            </xsl:otherwise>
         </xsl:choose>
         <xsl:value-of select="//db:bibliography/db:biblioentry[@xreflabel=$citeref]/db:pubdate"/>
      </a>
      <xsl:text>)</xsl:text>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- outputs the bibliography entry -->
   <!-- =============================================================== -->

   <xsl:template match="db:biblioentry[@role='book']">
      <p>
         <a id="{@xreflabel}"><xsl:text> </xsl:text></a>
         <!--[<xsl:value-of select="string(@xreflabel)"/>]--> 
         <xsl:apply-templates select="db:author/db:personname"/>
         <xsl:text>(</xsl:text><xsl:apply-templates select="db:pubdate"/><xsl:text>), </xsl:text>
         <xsl:if test="./db:editor"><xsl:text>ed. </xsl:text></xsl:if>
         <xsl:apply-templates select="db:editor/db:personname"/>
         <xsl:apply-templates select="db:citetitle"/>
         <xsl:apply-templates select="db:edition"/>
         <xsl:apply-templates select="db:publisher"/>
         <xsl:apply-templates select="db:bibliomisc"/>
      </p>
   </xsl:template>

   <xsl:template match="db:biblioentry[@role='article']">
      <p>
         <a id="{@xreflabel}"><xsl:text> </xsl:text></a>
         <!--[<xsl:value-of select="string(@xreflabel)"/>]--> 
         <xsl:apply-templates select="db:author/db:personname"/>
         <xsl:if test="./db:editor"><xsl:text>ed. </xsl:text></xsl:if>
         <xsl:apply-templates select="db:editor/db:personname"/>
         <xsl:apply-templates select="db:pubdate"/><xsl:text>, </xsl:text>
         <xsl:apply-templates select="db:citetitle"/>
         <xsl:apply-templates select="db:publisher"/>
         <xsl:apply-templates select="db:bibliomisc"/>
      </p>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- process bibliographic entries -->
   <!-- =============================================================== -->

   <xsl:template match="db:biblioentry/db:author/db:personname | db:biblioentry/db:editor/db:personname">
      <xsl:apply-templates select="db:surname"/><xsl:text>, </xsl:text>
      <xsl:if test="child::db:firstname">
         <xsl:value-of select="substring(string(child::db:firstname),1,1)"/><xsl:text>.</xsl:text>
      </xsl:if>
      <!-- process initials in 'othername' -->
      <xsl:if test="child::db:othername">
         <xsl:call-template name="other-name">
            <xsl:with-param name="other-names">
               <xsl:value-of select="child::db:othername"/>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:if>
      <xsl:choose>
         <xsl:when test="((name(parent::node())='author') and not(parent::node()/following-sibling::db:author[2]) and (parent::node()/following-sibling::db:author[1])) or 
                         ((name(parent::node())='editor') and not(parent::node()/following-sibling::db:editor[2]) and (parent::node()/following-sibling::db:editor[1]))"><xsl:text> and </xsl:text>
         </xsl:when>
         <xsl:otherwise><xsl:text> </xsl:text></xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="other-name">
      <xsl:param name="middle-initials" select="''"/>
      <xsl:param name="other-names" select="''"/>
      <xsl:choose>
         <!-- following collects middle names/initials for output before surname -->
         <xsl:when test="contains(string($other-names),' ')">
            <xsl:call-template name="other-name">
               <xsl:with-param name="middle-initials">
                  <xsl:value-of select="$middle-initials"/>
                  <xsl:value-of select="substring(string($other-names),1,1)"/>.
                  <xsl:if test="contains(substring-after(string($other-names),' '),' ')">
                     <xsl:text> </xsl:text>
                  </xsl:if>
               </xsl:with-param>
               <xsl:with-param name="other-names">
                  <xsl:value-of select="substring-after(string($other-names),' ')"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <xsl:when test="not(contains(string($other-names),' '))">
            <xsl:value-of select="$middle-initials"/>
            <xsl:value-of select="substring(string($other-names),1,1)"/><xsl:text>.</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:if test="$middle-initials = ''">
               <xsl:value-of select="substring($other-names,1,1)"/><xsl:text>. </xsl:text>
            </xsl:if>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="db:citetitle"><xsl:text>&#x201C;</xsl:text><i><xsl:apply-templates/></i><xsl:text>&#x201D;, </xsl:text></xsl:template>

   <xsl:template match="db:edition"><xsl:apply-templates/><xsl:text> edition, </xsl:text></xsl:template>

   <xsl:template match="db:publisher"><xsl:apply-templates/><xsl:text>. </xsl:text></xsl:template>
   
   <xsl:template match="db:bibliomisc[@role='note']"><xsl:apply-templates/><xsl:text>. </xsl:text></xsl:template>

</xsl:stylesheet>
