<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                exclude-result-prefixes="db xlink">

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
   <!-- Body paragraph.

        New version with context-sensitive Drop Caps
        It assumes that an optional mediaobject is the first or second child::node()

        Condition attribute signifies CSS class
        Property attribute signifies style property 
     -->
   <!-- =============================================================== -->

   <xsl:template match="db:para">
      <xsl:element name="p">
         <xsl:if test="@condition=true()">
            <xsl:attribute name="class">
               <xsl:value-of select="string(@condition)"/>
            </xsl:attribute>
         </xsl:if>
         <xsl:if test="@property=true()">
            <xsl:attribute name="style">
               <xsl:value-of select="string(@property)"/>
            </xsl:attribute>
         </xsl:if>
         <xsl:choose>
            <xsl:when test="$dropped-caps='yes'">
               <xsl:choose>
                  <xsl:when test="((name(preceding-sibling::node()[1]) = 'info') and (position()=2)) or
                                  ((name(preceding-sibling::node()[1]) = 'epigraph') and (position()&lt;=4)) or
                                  ((name(preceding-sibling::node()[1]) = 'mediaobject') and (position()&lt;=4)) or
                                  ((name(preceding-sibling::node()[1]) = 'literallayout') and (position()&lt;=3)) or
                                  ((name(preceding-sibling::node()[1]) = 'title') and (parent::node() = (//db:sect1)[1]) and (position()&lt;=4)) or
                                  ((preceding-sibling::node()[1]/attribute::role = 'byline') and (@role=false()))">
                     <!-- drop cap from first character -->
                     <xsl:choose>
                        <xsl:when test="name(child::node()[1])='quote'">
                           <xsl:call-template name="drop-cap-quote"/>
                        </xsl:when>
                        <xsl:when test="name(child::node()[1])='link'">
                           <xsl:call-template name="drop-cap-link"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:call-template name="drop-cap"/>
                        </xsl:otherwise>
                     </xsl:choose>                
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:apply-templates/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:apply-templates/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:element>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- Two versions of drop-cap to cover two use-cases -->
   <!-- =============================================================== -->

   <xsl:template name="drop-cap">
      <span style="float: left;">
         <span class="dropCap">
            <xsl:value-of select="substring(text(),1,1)"/>
         </span>
      </span>
      <xsl:variable name="cap-text">
         <xsl:value-of select="substring(substring-before(text(),' '),2,string-length(substring-before(text(),' ')))"
                       disable-output-escaping="yes"/>
      </xsl:variable>
      <xsl:value-of select="translate($cap-text,
                            'abcdefghijklmnopqrstuvwxyz',
                            'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" disable-output-escaping="yes"/>
      <xsl:if test="string-length($cap-text)!=0">
         <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:variable name="cap2-text">
         <xsl:value-of select="substring-before(substring-after(text(),' '),' ')"
                       disable-output-escaping="yes"/>
      </xsl:variable>
      <xsl:value-of select="translate($cap2-text,
                            'abcdefghijklmnopqrstuvwxyz',
                            'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" disable-output-escaping="yes"/>
      <xsl:if test="string-length($cap2-text)!=0">
         <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:value-of select="substring-after(
                            substring-after(child::node()[1],' '),
                            ' ')" disable-output-escaping="yes"/>
      <xsl:apply-templates select="child::node()/following-sibling::node()"/>
   </xsl:template>

   <xsl:template name="drop-cap-quote">
      <xsl:variable name="this-quote"><xsl:value-of select="child::db:quote[1]"/></xsl:variable>
      <span style="float: left;">
         <span class="dropCap">
            &#x201C;<xsl:value-of select="substring($this-quote,1,1)"/>
         </span>
      </span>
      <xsl:variable name="cap-text">
         <xsl:value-of select="substring(substring-before($this-quote,' '),2,string-length(substring-before($this-quote,' ')))"
                       disable-output-escaping="yes"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="$cap-text='' and string-length(substring-after($this-quote,' '))&lt;2"> <!-- single letter quote -->
            <xsl:value-of select="translate(substring($this-quote,2,string-length($this-quote)),
                                  'abcdefghijklmnopqrstuvwxyz',
                                  'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" disable-output-escaping="yes"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="translate($cap-text,
                                  'abcdefghijklmnopqrstuvwxyz',
                                  'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" disable-output-escaping="yes"/>
            <xsl:text> </xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="cap2-text">
         <xsl:value-of select="substring-before(substring-after($this-quote,' '),' ')" 
                       disable-output-escaping="yes"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="$cap2-text=''">
            <xsl:value-of select="translate(substring-after($this-quote,' '),
                                  'abcdefghijklmnopqrstuvwxyz',
                                  'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" disable-output-escaping="yes"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="translate($cap2-text,
                                  'abcdefghijklmnopqrstuvwxyz',
                                  'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" disable-output-escaping="yes"/>
            <xsl:text> </xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="substring-after(substring-after(child::node()[1],' '),' ')" disable-output-escaping="yes"/>&#x201D;<xsl:apply-templates select="child::node()/following-sibling::node()"/>
   </xsl:template>

   <xsl:template name="drop-cap-link">
      <xsl:variable name="this-link"><xsl:value-of select="child::db:link[1]"/></xsl:variable>
      <span style="float: left;">
         <span class="dropCap">
            <xsl:value-of select="substring($this-link,1,1)"/>
         </span>
      </span>
      <xsl:variable name="cap-text">
         <xsl:value-of select="substring(substring-before($this-link,' '),2,string-length(substring-before($this-link,' ')))"
                       disable-output-escaping="yes"/>
      </xsl:variable>
      <xsl:element name="a">
         <xsl:attribute name="href"><xsl:value-of select="child::db:link[1]/attribute::xlink:href"/></xsl:attribute>
      <xsl:choose>
         <xsl:when test="$cap-text='' and string-length(substring-after($this-link,' '))&lt;2"> <!-- single letter quote -->
            <xsl:value-of select="translate(substring($this-link,2,string-length($this-link)),
                                  'abcdefghijklmnopqrstuvwxyz',
                                  'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" disable-output-escaping="yes"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="translate($cap-text,
                                  'abcdefghijklmnopqrstuvwxyz',
                                  'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" disable-output-escaping="yes"/>
            <xsl:text> </xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="cap2-text">
         <xsl:value-of select="substring-before(substring-after($this-link,' '),' ')" 
                       disable-output-escaping="yes"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="$cap2-text=''">
            <xsl:value-of select="translate(substring-after($this-link,' '),
                                  'abcdefghijklmnopqrstuvwxyz',
                                  'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" disable-output-escaping="yes"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="translate($cap2-text,
                                  'abcdefghijklmnopqrstuvwxyz',
                                  'ABCDEFGHIJKLMNOPQRSTUVWXYZ')" disable-output-escaping="yes"/>
            <xsl:text> </xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="substring-after(substring-after(child::node()[1],' '),' ')" disable-output-escaping="yes"/>
      </xsl:element>
      <xsl:apply-templates select="child::node()/following-sibling::node()"/>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- simpara renders as badge -->
   <!-- =============================================================== -->

   <xsl:template match="db:simpara">
      <xsl:choose>
         <xsl:when test="@role=true()">
            <xsl:element name="{@role}">
               <xsl:element name="span">
                  <xsl:if test="@property=true()">
                     <xsl:attribute name="style">
                        <xsl:value-of select="string(@property)"/>
                     </xsl:attribute>
                  </xsl:if>
                  <xsl:apply-templates/>
               </xsl:element>
            </xsl:element>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="p">
               <xsl:if test="@property=true()">
                  <xsl:attribute name="style">
                     <xsl:value-of select="string(@property)"/>
                  </xsl:attribute>
               </xsl:if>
               <xsl:apply-templates/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- numbered section headings -->
   <!-- =============================================================== -->

   <xsl:template match="db:sect1 | db:sect2 | db:sect3">
      <xsl:choose>
         <xsl:when test="child::db:info">
            <section>
               <a id="{@xml:id}"><xsl:text> </xsl:text></a>
               <xsl:apply-templates/>
            </section>
            <footer>
               <a href="{$site-url}{$file-name}.html#{@xml:id}" class="small">Permalink</a>
            </footer>
            <xsl:if test="not(position()=last())">
               <hr><xsl:text> </xsl:text></hr>
               <div align="right" class="blockLabel"> <a class="link" href="#top">return to Top</a> </div>
            </xsl:if>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="db:sect1/db:info | db:sect2/db:info | db:sect3/db:info">
      <xsl:apply-templates select="db:pubdate"/>
      <xsl:apply-templates select="db:title"/>
   </xsl:template>

   <xsl:template match="db:sect1/db:info/db:title | db:sect2/db:info/db:title | db:sect3/db:info/db:title |
                        db:sect1/db:title | db:sect2/db:title | db:sect3/db:title |
                        db:section/db:title | db:simplesect/db:title">
      <xsl:choose>
         <xsl:when test="parent::db:info/parent::db:sect1">
            <h2>
               <xsl:element name="a">
                  <xsl:attribute name="href">
                     <xsl:value-of select="$site-url"/>
                     <xsl:value-of select="$file-name"/><xsl:text>.html#</xsl:text>
                     <xsl:value-of select="parent::db:info/parent::db:sect1/attribute::xml:id"/>
                  </xsl:attribute>
                  <xsl:attribute name="title">
                     <xsl:apply-templates mode="heading"/>
                  </xsl:attribute>
                  <xsl:attribute name="rel">bookmark</xsl:attribute>
                  <xsl:call-template name="sect-number"/>
                  <xsl:apply-templates/>
               </xsl:element>
            </h2>
         </xsl:when>
         <xsl:when test="parent::db:sect1">
            <h2>
               <xsl:element name="a">
                  <xsl:attribute name="id">
                     <xsl:value-of select="parent::node()/attribute::xml:id"/>
                  </xsl:attribute>
                  <xsl:attribute name="title">
                     <xsl:apply-templates mode="heading"/>
                  </xsl:attribute>
                  <xsl:attribute name="rel">bookmark</xsl:attribute>
                  <xsl:call-template name="sect-number"/>
                  <xsl:apply-templates/>
               </xsl:element>
            </h2>
         </xsl:when>
         <xsl:when test="parent::db:info/parent::db:sect2 or parent::db:sect2">
            <h3>
               <xsl:call-template name="sect-number"/>
               <xsl:apply-templates/>
            </h3>
         </xsl:when>
         <xsl:when test="parent::db:info/parent::db:sect3 or parent::db:sect3">
            <h4>
               <xsl:call-template name="sect-number"/>
               <xsl:apply-templates/>
            </h4>
         </xsl:when>
         <xsl:when test="parent::db:section or parent::db:simplesect">
            <xsl:if test="normalize-space(.)">
               <h2>
                  <xsl:element name="a">
                     <xsl:attribute name="id">
                        <xsl:value-of select="parent::node()/attribute::xml:id"/>
                     </xsl:attribute>
                     <xsl:attribute name="title">
                        <xsl:apply-templates mode="heading"/>
                     </xsl:attribute>
                     <xsl:text> </xsl:text>
                  </xsl:element>
                  <xsl:apply-templates/>
               </h2>
            </xsl:if>
         </xsl:when>
      </xsl:choose>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- Section numbering if enabled -->
   <!-- =============================================================== -->
   
   <xsl:template name="sect-number">
      <xsl:if test="$sect-number='on'">
         <xsl:choose>
            <xsl:when test="parent::db:info/parent::db:sect1 or parent::db:sect1">
               <xsl:number level="any" count="//db:sect1" format="1"/>
            </xsl:when>
            <xsl:when test="parent::db:info/parent::db:sect2 or parent::db:sect2">
               <xsl:number level="any" count="//db:sect1" format="1"/>.<xsl:number level="any" count="//db:sect2" from="db:sect1" format="1"/>
            </xsl:when>
            <xsl:when test="parent::db:info/parent::db:sect1 or parent::db:sect1">
               <xsl:number level="any" count="//db:sect1" format="1"/>.<xsl:number level="any" count="//db:sect2" from="db:sect1" format="1"/>.<xsl:number level="any" count="//db:sect3" from="db:sect2" format="1"/>
            </xsl:when>
         </xsl:choose>
         <xsl:text> </xsl:text>
      </xsl:if>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- unnumbered section heading -->
   <!-- =============================================================== -->

   <xsl:template match="db:bridgehead">
      <xsl:choose>
         <xsl:when test="@renderas='sect1'">
            <xsl:element name="h2"><xsl:apply-templates/></xsl:element>
         </xsl:when>
         <xsl:when test="@renderas='sect2'">
            <xsl:element name="h3"><xsl:apply-templates/></xsl:element>
         </xsl:when>
         <xsl:when test="@renderas='sect3'">
            <xsl:element name="h4"><xsl:apply-templates/></xsl:element>
         </xsl:when>
      </xsl:choose>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- simple sections -->
   <!-- =============================================================== -->

   <xsl:template match="db:section">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="db:simplesect">
      <xsl:apply-templates select="db:title"/>
      <div class="row">
         <xsl:apply-templates select="db:formalpara"/>
      </div>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- quoted block -->
   <!-- =============================================================== -->

   <xsl:template match="db:blockquote">
      <blockquote>
         <xsl:apply-templates select="db:para"/>
      </blockquote>
      <xsl:apply-templates select="db:attribution"/>
   </xsl:template>

   <xsl:template match="db:epigraph">
      <div class="lead">
         <xsl:apply-templates select="db:para"/>
         <xsl:apply-templates select="db:attribution"/>
      </div>
   </xsl:template>

   <xsl:template match="db:attribution">
      <xsl:element name="p">
         <xsl:if test="following-sibling::db:para[@role]=true()">
            <xsl:attribute name="class">
               <xsl:value-of select="following-sibling::db:para/attribute::role"/>
            </xsl:attribute>
         </xsl:if>
         <xsl:attribute name="style">text-align: right;</xsl:attribute>
         <xsl:text disable-output-escaping="yes">&amp;mdash; </xsl:text>
         <i><xsl:apply-templates/></i>
      </xsl:element>
   </xsl:template>

   <xsl:template match="db:literallayout">
      <pre>
         <xsl:apply-templates/>
      </pre>
   </xsl:template>

   <xsl:template match="db:formalpara">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="db:formalpara/db:title">
      <h3>
         <xsl:apply-templates/>
      </h3>
   </xsl:template>

   <xsl:template match="db:formalpara/db:para">
      <p>
         <xsl:apply-templates/>
      </p>
   </xsl:template>

</xsl:stylesheet> 
