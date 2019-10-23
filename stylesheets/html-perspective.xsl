<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml">
   
   <xsl:output method="xml" 
               encoding="UTF-8" 
               media-type="text/html" 
               indent="yes"
               omit-xml-declaration="yes"
               xmlns="http://www.w3.org/1999/xhtml"
               doctype-system="about:legacy-compat"/>

   <xsl:strip-space elements="*"/>

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
   <!-- includes -->
   <!-- =============================================================== -->

   <xsl:include href="param.xsl"/>

   <xsl:param name="color.main">#BBE4FF</xsl:param>
   <xsl:param name="body.width">960</xsl:param>

   <!-- =============================================================== -->
   <!-- match root element -->
   <!-- =============================================================== -->

   <xsl:template match="document">
      <html lang="en-GB">
         <head>
            <meta charset="UTF-8" />
            <meta http_equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <title><xsl:apply-templates select="info/title" mode="heading"/></title>
            <xsl:apply-templates select="info/author" mode="heading"/>
            <xsl:apply-templates select="info/copyright" mode="heading"/>
            <xsl:apply-templates select="info/subtitle" mode="heading"/>
            <xsl:apply-templates select="info/keywords"/>
            <meta name="generator" content="perspective XSL Stylesheets V2.1"/>
            <link type="text/css" rel="stylesheet" href="{$path-name}stylesheets/perspective.css"/>
            <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
            <xsl:comment>[if lt IE 9]&gt;
    <![CDATA[<script src="scripts/html5shiv.js"></script>]]>
    &lt;![endif]</xsl:comment>
         </head>
         <body style="padding: 60px 15px 0;">
            <article>
               <header>
                  <a id="top"><xsl:text> </xsl:text></a>
                  <div style="position: absolute; top: 0px; left: 0px; width: 100%; height: 50px; background-color: {$color.main};"><xsl:text> </xsl:text></div>
                  <xsl:choose>
                     <xsl:when test="descendant::info/child::date">
                        <xsl:apply-templates select="info/date"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <div class="date"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></div>
                     </xsl:otherwise>
                  </xsl:choose>
                  <xsl:apply-templates select="info/title"/>
                  <xsl:apply-templates select="info/subtitle"/>
                  <xsl:apply-templates select="info/author"/>
                  <hr class="dashed" />
                  <xsl:apply-templates select="info/introduction"/>
                  <xsl:apply-templates select="info/revhistory"/>
                  <xsl:choose>
                     <xsl:when test="descendant::bloginfo">
                        <xsl:call-template name="table-of-contents">
                           <xsl:with-param name="section">bloginfo</xsl:with-param>
                        </xsl:call-template>
                        <hr class="dashed"/>
                     </xsl:when>
                     <xsl:when test="descendant::section">
                        <xsl:call-template name="table-of-contents">
                           <xsl:with-param name="section">section</xsl:with-param>
                        </xsl:call-template>
                        <hr class="dashed"/>
                     </xsl:when>
                  </xsl:choose>
               </header>
               <xsl:apply-templates select="body"/>
               <xsl:apply-templates select="//p/footnote | //center/footnote | //pre/footnote" mode="endnotes"/>
               <xsl:apply-templates select="bibliography"/>
               <hr/>
            </article>
            <footer>
               <p class="blockxx">
                  <xsl:choose>
                     <xsl:when test="//info/copyright">
                        <xsl:text>Copyright © </xsl:text><xsl:apply-templates select="info/copyright/year"/><xsl:text> </xsl:text><xsl:apply-templates select="info/copyright/owner"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:text>&#160;</xsl:text>
                     </xsl:otherwise>
                  </xsl:choose>
               </p>
            </footer>
         </body>
      </html>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- 'root' tags -->
   <!-- =============================================================== -->

   <xsl:template match="info/introduction">
      <div class="abstract">
         <div class="blockx">
            <xsl:choose>
               <xsl:when test="name(child::node())='p'">
                  <xsl:apply-templates select="p" mode="emptypara"/>
               </xsl:when>
               <xsl:otherwise>
                  <strong>Abstract:</strong><xsl:text> </xsl:text><xsl:apply-templates/>
               </xsl:otherwise>
            </xsl:choose>
         </div>
      </div>
   </xsl:template>

   <xsl:template match="introduction/p" mode="emptypara">
      <xsl:if test="position()=1">
         <p><strong>Abstract:</strong><xsl:text> </xsl:text><xsl:apply-templates/></p>
      </xsl:if>
      <xsl:if test="position()&gt;1">
         <p><xsl:apply-templates/></p>
      </xsl:if>
   </xsl:template>

   <xsl:template match="info/author" mode="heading">
      <xsl:element name="meta">
         <xsl:attribute name="name">author</xsl:attribute>
         <xsl:attribute name="content">
            <xsl:apply-templates/>
         </xsl:attribute>
      </xsl:element>
   </xsl:template>

   <xsl:template match="info/author">
      <p class="byline">
         <xsl:text>by </xsl:text><xsl:value-of select="."/>
         <xsl:text> &lt;</xsl:text><a href="mailto:{$email-address}"><xsl:value-of select="$email-address"/></a><xsl:text>&gt;</xsl:text>
      </p>
   </xsl:template>
   
   <xsl:template match="info/copyright" mode="heading">
      <xsl:element name="meta">
         <xsl:attribute name="name">copyright</xsl:attribute>
         <xsl:attribute name="content">
            <xsl:value-of select="child::owner"/>
         </xsl:attribute>
      </xsl:element>
   </xsl:template>

   <xsl:template match="info/subtitle" mode="heading">
      <xsl:element name="meta">
         <xsl:attribute name="name">description</xsl:attribute>
         <xsl:attribute name="content">
            <xsl:apply-templates mode="heading"/>
         </xsl:attribute>
      </xsl:element>
   </xsl:template>

   <xsl:template match="info/keywords">
      <xsl:element name="meta">
         <xsl:attribute name="name">keywords</xsl:attribute>
         <xsl:attribute name="content">
            <xsl:apply-templates/>
         </xsl:attribute>
      </xsl:element>
   </xsl:template>

   <xsl:template match="info/date | bloginfo/date">
      <div class="date"><xsl:apply-templates/></div>
   </xsl:template>

   <xsl:template match="info/title">
      <h1>
         <xsl:choose>
            <xsl:when test="not(parent::info/following-sibling::body/child::blog)">
               <xsl:element name="a">
                  <xsl:attribute name="href">
                     <xsl:value-of select="$site-url"/>
                     <xsl:value-of select="$file-name"/>.htm</xsl:attribute>
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
      </h1>
   </xsl:template>

   <xsl:template match="info/subtitle">
      <h3><xsl:apply-templates/></h3>
   </xsl:template>

   <xsl:template match="section/title">
      <h2>
         <xsl:element name="a">
            <xsl:attribute name="id">
               <xsl:value-of select="parent::section/attribute::id"/>
            </xsl:attribute>
            <xsl:attribute name="title">
               <xsl:apply-templates mode="heading"/>
            </xsl:attribute>
            <xsl:attribute name="rel">bookmark</xsl:attribute>
            <xsl:call-template name="sect-number"/>
            <xsl:apply-templates/>
         </xsl:element>
      </h2>
   </xsl:template>

   <xsl:template name="sect-number">
      <xsl:if test="$sect-number='on'">
         <xsl:if test="parent::section">
            <xsl:number level="any" count="//section" format="1"/>
         </xsl:if>
      </xsl:if>
      <xsl:text> </xsl:text>
   </xsl:template>

   <xsl:template match="bloginfo/title">
      <h1>
         <xsl:element name="a">
            <xsl:attribute name="href">
               <xsl:value-of select="$site-url"/>
               <xsl:value-of select="$file-name"/><xsl:text>.htm#</xsl:text><xsl:value-of select="ancestor::blog/attribute::id"/>
            </xsl:attribute>
            <xsl:attribute name="title">
               <xsl:apply-templates mode="heading"/>
            </xsl:attribute>
            <xsl:attribute name="rel">bookmark</xsl:attribute>
            <xsl:apply-templates/>
         </xsl:element>
      </h1>
   </xsl:template>

   <xsl:template match="info/title" mode="heading">
      <xsl:apply-templates mode="heading"/>
   </xsl:template>

   <xsl:template match="copyright/year">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="copyright/owner">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="body">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="section">
      <xsl:apply-templates/>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- table of contents -->
   <!-- =============================================================== -->

   <xsl:template name="table-of-contents">
      <xsl:param name="section">bloginfo</xsl:param>
      <xsl:choose>
         <xsl:when test="string($section)='bloginfo'">
            <h3>Contents</h3>
            <xsl:for-each select="//bloginfo/title">
               <p>
                  <xsl:element name="a">
                     <xsl:attribute name="href">
                        <xsl:value-of select="$site-url"/><xsl:value-of select="$file-name"/><xsl:text>.htm</xsl:text>
                        <xsl:text>#</xsl:text>
                        <xsl:value-of select="ancestor::blog/attribute::id"/>
                     </xsl:attribute>
                     <xsl:apply-templates/>
                  </xsl:element>
               </p>
            </xsl:for-each>
         </xsl:when>
         <xsl:when test="string($section)='section'">
            <h3>Contents</h3>
            <xsl:for-each select="//section/title[1]">
               <p>
                  <xsl:element name="a">
                     <xsl:attribute name="href">
                        <xsl:text>#</xsl:text>
                        <xsl:value-of select="(ancestor::section)[1]/attribute::id"/>
                     </xsl:attribute>
                     <xsl:apply-templates/>
                  </xsl:element>
               </p>
            </xsl:for-each>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
      
   <!-- =============================================================== -->
   <!-- blog entries -->
   <!-- =============================================================== -->

   <xsl:template match="blog">
      <a id="{@id}"><xsl:text> </xsl:text></a>
      <xsl:apply-templates select="bloginfo/date"/>
      <xsl:apply-templates select="bloginfo/title"/>
      <xsl:apply-templates/>
      <a href="{$site-url}{$file-name}.htm#{@id}" class="blockxx">Permalink</a>
      <xsl:if test="position()!=last()">
         <hr/>
         <div align="right" class="blockLabel">
            <a class="link" href="#top">return to Top</a>
         </div>
      </xsl:if>
   </xsl:template>

   <xsl:template match="bloginfo">
   </xsl:template>
   
   <!-- =============================================================== -->
   <!-- horizontal rule -->
   <!-- =============================================================== -->

   <xsl:template match="hr">
      <xsl:element name="hr"/>
   </xsl:template>

   <xsl:template match="byline">
      <p class="byline">
         <xsl:apply-templates/>
      </p>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- Body paragraph -->
   <!-- With context-sensitive Drop Caps -->
   <!-- =============================================================== -->

   <xsl:template match="p">
      <xsl:element name="p">
         <xsl:if test="@align=true()">
            <xsl:attribute name="style">text-align: <xsl:value-of select="string(@align)"/>;</xsl:attribute>
         </xsl:if>
         <xsl:if test="@class=true()">
            <xsl:attribute name="class"><xsl:value-of select="string(@class)"/></xsl:attribute>
         </xsl:if>
         <xsl:choose>
            <xsl:when test="$dropped-caps='yes'">
               <xsl:choose>
                  <xsl:when test="((name(parent::node()) = 'body') and (position()=1)) or 
                                  ((name(preceding-sibling::node()[1]) = 'blockquote') and (position()&lt;=3)) or
                                  ((name(preceding-sibling::node()[1]) = 'epigraph') and (position()&lt;=4)) or
                                  ((name(preceding-sibling::node()[1]) = 'img') and (position()&lt;=4)) or
                                  ((name(preceding-sibling::node()[1]) = 'pre') and (position()&lt;=3)) or
                                  ((name(preceding-sibling::node()[1]) = 'bloginfo') and (position()&lt;=3)) or
                                  ((name(preceding-sibling::node()[1]) = 'title') and (parent::node() = (//section)[1]) and (position()&lt;=4)) or
                                  (name(preceding-sibling::node()[1]) = 'byline')">
                     <!-- drop cap from first character -->
                     <xsl:choose>
                        <xsl:when test="name(child::node()[1])='q'">
                           <xsl:call-template name="drop-cap-quote"/>
                        </xsl:when>
                        <xsl:when test="name(child::node()[1])='a'">
                           <xsl:call-template name="drop-cap-href"/>
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
   <!-- Three versions of drop-cap to cover three use-cases -->
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
      <xsl:variable name="this-quote"><xsl:value-of select="child::q[1]"/></xsl:variable>
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

   <xsl:template name="drop-cap-href">
      <xsl:variable name="this-href"><xsl:value-of select="child::a[1]"/></xsl:variable>
      <span style="float: left;">
         <span class="dropCapx">
            <xsl:value-of select="substring($this-href,1,1)"/>
         </span>
      </span>
      <xsl:variable name="cap-text">
         <xsl:value-of select="substring(substring-before($this-href,' '),2,string-length(substring-before($this-href,' ')))"
                       disable-output-escaping="yes"/>
      </xsl:variable>
      <xsl:element name="a">
         <xsl:attribute name="href"><xsl:value-of select="child::a[1]/attribute::href"/></xsl:attribute>
      <xsl:choose>
         <xsl:when test="$cap-text='' and string-length(substring-after($this-href,' '))&lt;2">
            <xsl:value-of select="translate(substring($this-href,2,string-length($this-href)),
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
         <xsl:value-of select="substring-before(substring-after($this-href,' '),' ')" 
                       disable-output-escaping="yes"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="$cap2-text=''">
            <xsl:value-of select="translate(substring-after($this-href,' '),
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
      <xsl:value-of select="substring-after(substring-after(child::node()[1],' '),' ')" disable-output-escaping="yes"/></xsl:element><xsl:apply-templates select="child::node()/following-sibling::node()"/>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- center on a new line -->
   <!-- =============================================================== -->

   <xsl:template match="center">
      <xsl:choose>
         <xsl:when test="@class=true()">
            <p class="{@class}" style="text-align: center;"><xsl:apply-templates/></p>
         </xsl:when>
         <xsl:otherwise>
            <p style="text-align: center;"><xsl:apply-templates/></p>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- preformatted text -->
   <!-- =============================================================== -->

   <xsl:template match="pre">
      <pre>
         <xsl:apply-templates/>
      </pre>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- handle ordered lists in the form   -->
   <!--    <enumerate>                     -->
   <!--        <item>...</item>            -->
   <!--        <item>...</item>            -->
   <!--    </enumerate>                    -->
   <!-- =============================================================== -->


   <xsl:template match="enumerate">
      <xsl:element name="ol">
         <xsl:if test="@style=true()">
            <xsl:choose>
               <xsl:when test="@style='a'">
                  <xsl:attribute name="style">list-style-type: lower-alpha;</xsl:attribute>
               </xsl:when>
               <xsl:when test="@style='A'">
                  <xsl:attribute name="style">list-style-type: upper-alpha;</xsl:attribute>
               </xsl:when>
               <xsl:when test="@style='i'">
                  <xsl:attribute name="style">list-style-type: lower-roman;</xsl:attribute>
               </xsl:when>
               <xsl:when test="@style='I'">
                  <xsl:attribute name="style">list-style-type: upper-roman;</xsl:attribute>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="style">list-style-type: decimal;</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>                
         </xsl:if>
         <xsl:if test="@class=true()">
            <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
         </xsl:if>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- handle bulleted lists in the form  -->
   <!--    <itemize>                       -->
   <!--        <item>...</item>            -->
   <!--        <item>...</item>            -->
   <!--    </itemize>                      -->
   <!-- =============================================================== -->

   <xsl:template match="itemize">
      <ul><xsl:apply-templates/></ul>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- for both types of itemization -->
   <!-- =============================================================== -->

   <xsl:template match="item">
      <xsl:choose>
         <xsl:when test="@class=true()">
            <li><div class="{@class}"><xsl:apply-templates/></div></li>
         </xsl:when>
         <xsl:otherwise>
            <li><xsl:apply-templates/></li>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!-- =============================================================== -->
   <!--    Handle LaTeX style bibliography entries                      -->
   <!-- =============================================================== -->
   <!--
       syntax is <cite>label</cite>                                (i)

       and then the bibliography database is a simple enumeration

       <bibliography>
          <bibitem tag="label">...</bibitem>                      (ii)
          <bibitem tag="another-label">...</bibitem>
          ...
       </bibliography>

       It is up to the document author to reconcile labels in cases (i) and (ii)
       -->
   <!-- =============================================================== -->

   <xsl:template match="bibliography">
      <h2>Bibliography</h2>
      <xsl:apply-templates/>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- creates a citation entry -->
   <!-- =============================================================== -->

   <xsl:template match="cite">
      <xsl:variable name="citeref" select="."/>
      <xsl:text>(</xsl:text>
      <a href="#{string(.)}"><xsl:value-of select="."/><xsl:text>, </xsl:text>
      <xsl:value-of select="//bibliography/bibitem[@label=$citeref]/year"/>
      </a>
      <xsl:text>)</xsl:text>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- outputs the bibliography item -->
   <!-- =============================================================== -->

   <xsl:template match="bibitem[@type='book']">
      <p>
         <a id="{@label}"><xsl:text> </xsl:text></a>
         <!--[<xsl:value-of select="string(@label)"/>] -->
         <xsl:apply-templates select="author" mode="bib"/>
         <xsl:if test="./editor"><xsl:text>ed. </xsl:text></xsl:if>
         <xsl:apply-templates select="editor" mode="bib"/> 
         <xsl:text>(</xsl:text><xsl:apply-templates select="year" mode="bib"/><xsl:text>), </xsl:text>
         <xsl:apply-templates select="title" mode="bib"/>
         <xsl:apply-templates select="edition" mode="bib"/>
         <xsl:apply-templates select="publisher" mode="bib"/>
         <xsl:apply-templates select="note" mode="bib"/>
      </p>
   </xsl:template>

   <xsl:template match="bibitem[@type='article']">
      <p>
         <a id="{@label}"><xsl:text> </xsl:text></a>
         <!--[<xsl:value-of select="string(@label)"/>] -->
         <xsl:apply-templates select="author" mode="bib"/>
         <xsl:if test="./editor"><xsl:text>ed. </xsl:text></xsl:if>
         <xsl:apply-templates select="editor" mode="bib"/> 
         <xsl:apply-templates select="month" mode="bib"/><xsl:text>, </xsl:text>
         <xsl:apply-templates select="year" mode="bib"/><xsl:text>. </xsl:text>
         <xsl:apply-templates select="title" mode="bib"/>
         <xsl:apply-templates select="journal" mode="bib"/>
         <xsl:apply-templates select="note" mode="bib"/>
      </p>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- process bibliographic entries -->
   <!-- =============================================================== -->

   <xsl:template name="names">
      <xsl:param name="author-names">John Doe and Jane Doe</xsl:param>
      <xsl:choose>
         <xsl:when test="contains(string($author-names),' and ')">
            <xsl:call-template name="current-surname">
               <xsl:with-param name="author-surname">
                  <xsl:value-of select="substring-before(string($author-names),' and ')"/>
               </xsl:with-param>
            </xsl:call-template><xsl:if test="contains(substring-after(string($author-names),' and '),' and ')"><xsl:text>, </xsl:text></xsl:if>
            <xsl:call-template name="names">
               <xsl:with-param name="author-names">
                  <xsl:value-of select="substring-after(string($author-names),' and ')"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:call-template name="current-surname">
               <xsl:with-param name="spacer-before" select="' and '"/>
               <xsl:with-param name="author-surname">
                  <xsl:value-of select="string($author-names)"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="current-surname">
      <xsl:param name="spacer-before" select="''"/>
      <xsl:param name="author-surname">John Doe</xsl:param>
      <xsl:value-of select="$spacer-before"/>
      <xsl:choose>
         <xsl:when test="contains(string($author-surname),' ')">
            <xsl:value-of select="substring(string($author-surname),1,1)"/><xsl:text>.</xsl:text><xsl:call-template name="current-surname">
               <xsl:with-param name="spacer-before"><xsl:value-of select="''"/></xsl:with-param>
               <xsl:with-param name="author-surname">
                  <xsl:value-of select="substring-after(string($author-surname),' ')"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text> </xsl:text><xsl:value-of select="string($author-surname)"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="bibitem/author | bibitem/editor" mode="bib">
      <xsl:choose>
         <xsl:when test="contains(string(.),' and ')">
            <xsl:call-template name="names">
               <xsl:with-param name="author-names"><xsl:apply-templates/></xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:call-template name="current-surname">
               <xsl:with-param name="author-surname"><xsl:apply-templates/></xsl:with-param>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose><xsl:text>, </xsl:text>
   </xsl:template>

   <xsl:template match="bibitem/month" mode="bib"><xsl:apply-templates/></xsl:template>

   <xsl:template match="bibitem/year" mode="bib"><xsl:apply-templates/></xsl:template>

   <xsl:template match="bibitem/title" mode="bib"><xsl:text>&#x201C;</xsl:text><i><xsl:apply-templates/></i><xsl:text>&#x201D;, </xsl:text></xsl:template>

   <xsl:template match="bibitem/edition" mode="bib"><xsl:apply-templates/><xsl:text> edition, </xsl:text></xsl:template>

   <xsl:template match="bibitem/publisher" mode="bib"><xsl:apply-templates/><xsl:text>. </xsl:text></xsl:template>
   
   <xsl:template match="bibitem/journal" mode="bib"><xsl:apply-templates/><xsl:text>. </xsl:text></xsl:template>

   <xsl:template match="bibitem/note" mode="bib"><xsl:apply-templates/><xsl:text>.</xsl:text></xsl:template>

   <!-- =============================================================== -->
   <!-- indents quoted block -->
   <!-- =============================================================== -->

   <xsl:template match="blockquote">
      <blockquote>
         <xsl:apply-templates/>
      </blockquote>
   </xsl:template>

   <xsl:template match="epigraph">
      <div class="epigraph">
         <xsl:apply-templates/>
      </div>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- handles href and name attributes of the a tag -->
   <!-- =============================================================== -->

   <xsl:template match="a[@href]">
      <xsl:choose>
         <xsl:when test="@type=true()">
            <!-- disable href extensions -->
            <xsl:apply-templates/>
         </xsl:when>
         <xsl:otherwise>
            <a href="{@href}"><xsl:apply-templates/></a>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="a[@name]">
      <a id="{@name}"><xsl:text> </xsl:text></a>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- Following automatically handles footnote numbering and          -->
   <!-- transformation to endnotes.                                     -->
   <!-- =============================================================== -->
   <!-- Outline of code as follows:                                     -->
   <!--                                                                 -->
   <!--    <xsl:template match="footnote">                              -->
   <!--       <xsl:text> </xsl:text>                                    -->
   <!--           <a id="backref-xx"></a>                               -->
   <!--           [<a href="footnote-xx">                               -->
   <!--               <xsl:number level="any" count="footnote"/>        -->
   <!--           </a>]                                                 -->
   <!--       <xsl:text> </xsl:text>                                    -->
   <!--    </xsl:template>                                              -->
   <!--                                                                 -->
   <!--    <xsl:template match="footnote" mode="endnotes">              -->
   <!--       <p>                                                       -->
   <!--           <a id="footnote-xx"></a>                              -->
   <!--           [<a href="backref-xx">                                -->
   <!--               <xsl:number level="any" count="footnote"/>        -->
   <!--           </a>]                                                 -->
   <!--           <xsl:text> </xsl:text>                                -->
   <!--           <xsl:apply-templates/>                                -->
   <!--       </p>                                                      -->
   <!--    </xsl:template>                                              -->
   <!-- =============================================================== -->

   <!-- =============================================================== -->
   <!-- auxiliary templates for footnotes -->
   <!-- =============================================================== -->

   <xsl:template name="backrefn">
      <a id="brf.{generate-id(.)}">
         <xsl:text> </xsl:text>
      </a>
   </xsl:template>

   <xsl:template name="backrefh">
      <xsl:param name="footnote-no">01</xsl:param>
      <a href="#brf.{generate-id(.)}">
         <xsl:value-of select="$footnote-no"/>
      </a>
   </xsl:template>

   <xsl:template name="footnoten">
      <a id="ftn.{generate-id(.)}">
         <xsl:text> </xsl:text>
      </a>
   </xsl:template>

   <xsl:template name="footnoteh">
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
      <xsl:if test="$footnote-no='1'">
         <h2>Endnotes:</h2>
      </xsl:if>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- generate footnote reference -->
   <!-- =============================================================== -->

   <xsl:template match="footnote">
      <xsl:text> </xsl:text>
      <xsl:call-template name="backrefn" />
      <xsl:text>[</xsl:text>
      <xsl:call-template name="footnoteh">
         <xsl:with-param name="footnote-no">
            <xsl:choose>
               <xsl:when test="parent::column">
                  <xsl:number level="any" count="column/footnote" from="table" format="a"/>
               </xsl:when>
               <xsl:otherwise> <!-- usually parent::p -->
                  <xsl:number level="any" count="p/footnote | center/footnote | pre/footnote" format="1"/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:with-param>
      </xsl:call-template>
      <xsl:text>] </xsl:text>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- generate endnotes -->
   <!-- =============================================================== -->

   <xsl:template match="footnote" mode="endnotes">
      <xsl:if test="parent::p | parent::center | parent::pre">
         <xsl:call-template name="endnotes">
            <xsl:with-param name="footnote-no">
               <xsl:number level="any" count="p/footnote | center/footnote | pre/footnote" format="1"/>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:if>
      <xsl:choose>
         <xsl:when test="child::p">
            <xsl:apply-templates select="p" mode="endnotes"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="p">
               <xsl:if test="parent::column">
                  <xsl:attribute name="class">blockxx</xsl:attribute>
               </xsl:if>
               <xsl:call-template name="footnoten"/>
               <xsl:text>[</xsl:text>
               <xsl:call-template name="backrefh">
                  <xsl:with-param name="footnote-no">
                     <xsl:choose>
                        <xsl:when test="parent::column">
                           <xsl:number level="any" count="column/footnote" from="table" format="a"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:number level="any" count="p/footnote | center/footnote | pre/footnote" format="1"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:text>] </xsl:text>
               <xsl:apply-templates/>
               <xsl:if test="not(ancestor::column)">
                  <xsl:text> </xsl:text>
                  <a href="#brf.{generate-id(.)}" title="Back">
                     <xsl:text> </xsl:text>
                  </a>
               </xsl:if>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="p" mode="endnotes">
      <xsl:element name="p">    
         <xsl:if test="ancestor::column">
            <xsl:attribute name="class">blockxx</xsl:attribute>
         </xsl:if>
         <xsl:if test="position()=1">
            <!-- footnoten with different id -->
            <a id="ftn.{generate-id(parent::footnote)}"><xsl:text> </xsl:text></a>
            <xsl:text>[</xsl:text>
            <xsl:call-template name="backrefh">
               <xsl:with-param name="footnote-no">
                  <xsl:if test="ancestor::p">
                     <xsl:number level="any" count="p/footnote" format="1"/>
                  </xsl:if>
                  <xsl:if test="ancestor::column">
                     <xsl:number level="any" count="column/footnote" from="table" format="a"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:text>] </xsl:text>
         </xsl:if>
         <xsl:apply-templates/>
         <xsl:if test="(position()=last()) and not(ancestor::column)">
            <xsl:text> </xsl:text>
            <a href="#brf.{generate-id(parent::footnote)}" title="Back">
               <xsl:text> </xsl:text>
            </a>
         </xsl:if>
      </xsl:element>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- rich-text styles: italic, bold and underline -->
   <!-- =============================================================== -->

   <xsl:template match="i">
      <em><xsl:apply-templates/></em>
   </xsl:template>

   <xsl:template match="b">
      <strong><xsl:apply-templates/></strong>
   </xsl:template>

   <xsl:template match="u">
      <u><xsl:apply-templates/></u>
   </xsl:template>

   <xsl:template match="sup">
      <sup><xsl:apply-templates/></sup>
   </xsl:template>

   <xsl:template match="sub">
      <sub><xsl:apply-templates/></sub>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- tele-type font -->
   <!-- =============================================================== -->

   <xsl:template match="tt">
      <code>
         <xsl:apply-templates/>
      </code>
   </xsl:template>
   
   <!-- =============================================================== -->
   <!-- annotations -->
   <!-- =============================================================== -->

   <xsl:template match="annotation">
      <xsl:text> </xsl:text>
   </xsl:template>

   <xsl:template match="title" mode="annotation">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="p" mode="annotation">
      <xsl:apply-templates/>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- section heading -->
   <!-- =============================================================== -->

   <xsl:template match="sub-heading">
      <h2>
         <xsl:apply-templates/>
      </h2>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- inserting graphics -->
   <!-- =============================================================== -->

   <xsl:template match="img">
      <xsl:choose>
         <xsl:when test="@align='center' or @align=false()">
            <div style="background-color: white;">
               <div style="width: {attribute::width}px; margin-left: auto; margin-right: auto;">
                  <xsl:choose>
                     <!-- Becomes 'svg' when possible to serve image/svg+xml -->
                     <xsl:when test="contains(string(@pdfres),'svg')">
                        <xsl:element name="object">
                           <xsl:attribute name="data"><xsl:value-of select="$path-name" /><xsl:value-of select="$image-folder"/>svg/<xsl:value-of select="@src"/>.svg</xsl:attribute>
                           <xsl:attribute name="type">image/svg+xml</xsl:attribute>
                           <xsl:call-template name="insert-graphic"/>
                        </xsl:element>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:call-template name="insert-graphic"/>
                     </xsl:otherwise>
                  </xsl:choose>
                  <xsl:apply-templates select="caption"/>
               </div>
            </div>
         </xsl:when>
         <xsl:otherwise>
            <div style="float: {@align};">
               <div style="padding: {@space}px; background-color: white;">
                  <xsl:choose>
                     <!-- Becomes 'svg' when possible to serve image/svg+xml -->
                     <xsl:when test="contains(string(@pdfres),'svg')">
                        <xsl:element name="object">
                           <xsl:attribute name="data"><xsl:value-of select="$path-name" /><xsl:value-of select="$image-folder"/>svg/<xsl:value-of select="@src"/>.svg</xsl:attribute>
                           <xsl:attribute name="type">image/svg+xml</xsl:attribute>
                           <xsl:call-template name="insert-graphic"/>
                        </xsl:element>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:call-template name="insert-graphic"/>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:apply-templates select="caption"/>
                  </div>
            </div>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- insert graphic -->
   <!-- =============================================================== -->

   <xsl:template name="insert-graphic">
      <xsl:element name="img">
         <xsl:attribute name="src">
            <xsl:value-of select="$path-name" /><xsl:value-of select="$image-folder" /><xsl:value-of select="@src" />
            <xsl:if test="@format=true()">.<xsl:value-of select="@format" /></xsl:if>
         </xsl:attribute>
         <xsl:attribute name="width">
            <xsl:value-of select="@width" />
         </xsl:attribute>
         <xsl:attribute name="height">
            <xsl:value-of select="@height" />
         </xsl:attribute>
         <xsl:attribute name="title">
            <xsl:value-of select="@alt" />
         </xsl:attribute>
         <xsl:attribute name="alt">
            <xsl:value-of select="@alt" />
         </xsl:attribute>
         <xsl:attribute name="style"><xsl:text>display: block; margin-left: auto; margin-right: auto;</xsl:text></xsl:attribute>
      </xsl:element>
   </xsl:template>

   <xsl:template match="caption">
      <p class="caption" 
         style="width: {parent::img/attribute::width}px;">
         <xsl:if test="@figure">
            <b>Figure <xsl:number level="any" count="caption[@figure]" format="1"/></b>
            <xsl:text> </xsl:text>
         </xsl:if>
         <xsl:apply-templates/>
      </p>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- revision history -->
   <!-- =============================================================== -->

   <xsl:template match="revhistory">
      <div class="table-responsive">
         <div style="width: 500px; margin-left: auto; margin-right: auto;" id="revhistory">
            <table class="tabular" style="text-align: left;">
               <colgroup>
                  <col style="width: 100px;" />
                  <col style="width: 400px;" />
               </colgroup>
               <thead class="revision">
                  <tr>
                     <th colspan="2" class="tabularhead">Revision History</th>
                  </tr>
               </thead>
               <tbody class="revision">
                  <tr>
                     <td class="tabularHeadText">Revision</td>
                     <td class="tabularHeadText">Date</td>
                  </tr>
                  <xsl:apply-templates select="revision"/>
               </tbody>
            </table>
         </div>
      </div>
   </xsl:template>

   <xsl:template match="revision">
      <tr>
         <td class="tabularBodyText"><xsl:apply-templates select="revnumber"/></td>
         <td class="tabularBodyText"><xsl:apply-templates select="revdate"/></td>
      </tr>
      <tr>
         <td class="tabularBodyText"><xsl:text> </xsl:text></td>
         <td class="tabularBodyText"><xsl:apply-templates select="revremark"/></td>
      </tr>
   </xsl:template>

   <xsl:template match="revnumber">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="revdate">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="revremark">
      <xsl:apply-templates/>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- simple table handling -->
   <!-- =============================================================== -->

   <xsl:template match="table">
      <xsl:choose>
         <xsl:when test="@align='center'">
            <xsl:element name="div">
               <xsl:attribute name="style">
                  <xsl:text>width: </xsl:text>
                  <xsl:apply-templates select="descendant::tgroup/columns" mode="sum"/>
                  <xsl:text>px;</xsl:text>
                  <xsl:text> margin-left: auto; margin-right: auto;</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="label"/>
               <table class="table">
                  <xsl:apply-templates select="tgroup"/>
               </table>
            </xsl:element>
         </xsl:when>
         <xsl:when test="@align=false()">
            <div class="table-responsive">
               <xsl:apply-templates select="label"/>
               <xsl:element name="table">
                  <xsl:attribute name="class">table</xsl:attribute>
                  <xsl:attribute name="style">width: <xsl:apply-templates select="descendant::tgroup/columns" mode="sum"/>px;</xsl:attribute>
                  <xsl:apply-templates select="tgroup"/>
               </xsl:element>
            </div>
         </xsl:when>
         <xsl:otherwise>
            <div style="float: {@align}; padding: 0px 5px;">
               <xsl:apply-templates select="label"/>
               <table class="table">
                  <xsl:apply-templates select="tgroup"/>
               </table>
            </div>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="tgroup/columns" mode="sum">
      <xsl:param name="col_total" select="0"/>
      <xsl:param name="print" select="1"/>
      <xsl:if test="following-sibling::columns">
         <xsl:apply-templates select="following-sibling::columns" mode="sum">
            <xsl:with-param name="col_total">
               <xsl:value-of select="number($col_total) + number(@width)"/>
            </xsl:with-param>
            <xsl:with-param name="print">
               <xsl:value-of select="number($print)+1"/>
            </xsl:with-param>
         </xsl:apply-templates>
      </xsl:if>
      <xsl:if test="number($print)=count(parent::tgroup/columns)">
         <xsl:value-of select="number($col_total) + number(@width)"/>
      </xsl:if>
   </xsl:template>

   <xsl:template match="table/label">
      <xsl:element name="p">
         <xsl:attribute name="class">caption</xsl:attribute>
         <xsl:attribute name="style">width: <xsl:apply-templates select="following-sibling::tgroup/columns" mode="sum"/>px;</xsl:attribute>
         <xsl:if test="@number='yes'">
            <b>Table <xsl:number level="any" count="//table/label[@number]" format="1"/></b>
            <xsl:text> </xsl:text>
         </xsl:if>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

   <xsl:template match="tgroup">
      <xsl:if test="child::columns">
         <colgroup>
            <xsl:apply-templates select="columns"/>
         </colgroup>
      </xsl:if>
      <xsl:apply-templates select="thead"/>
      <xsl:choose>
         <xsl:when test="child::node()/row/column/footnote">
            <tfoot>
               <xsl:choose>
                  <xsl:when test="child::tfoot">
                     <xsl:call-template name="tfooter"/>
                     <xsl:apply-templates select="tfoot"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:call-template name="tfooter"/>
                  </xsl:otherwise>
               </xsl:choose>
            </tfoot>
         </xsl:when>
         <xsl:when test="(child::tfoot) and not(child::node()/row/column/footnote)">
            <tfoot>
               <xsl:apply-templates select="tfoot"/>
            </tfoot>
         </xsl:when>
      </xsl:choose>
      <xsl:apply-templates select="tbody"/>
   </xsl:template>

   <xsl:template match="columns">
      <xsl:element name="col">
         <xsl:attribute name="style"><xsl:text>width: </xsl:text><xsl:value-of select="@width"/><xsl:text>px;</xsl:text></xsl:attribute>
         <xsl:if test="@repeated=true()">
            <xsl:attribute name="span"><xsl:value-of select="@repeated"/></xsl:attribute>
         </xsl:if>
         <!-- The align attribute on the HTML5 col element is obsolete. Use CSS instead. -->
         <!--
         <xsl:if test="@align=true()">
            <xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
         </xsl:if>
         -->
      </xsl:element>
   </xsl:template>

   <xsl:template match="thead">
      <thead class="theader">
         <xsl:apply-templates select="row"/>
      </thead>
   </xsl:template>

   <xsl:template name="tfooter">
      <tr>
         <td colspan="{@cols}" style="padding: 2px 3px;">
            <xsl:apply-templates select="child::node()/row/column/footnote" mode="endnotes"/>
         </td>
      </tr>
   </xsl:template>
   
   <xsl:template match="tfoot">
      <xsl:apply-templates select="row"/>
   </xsl:template>

   <xsl:template match="tbody">
      <tbody class="tbody">
         <xsl:apply-templates select="row"/>
      </tbody>
   </xsl:template>

   <xsl:template match="thead/row">
      <tr class="thead"><xsl:apply-templates select="column"/></tr>
   </xsl:template>

   <xsl:template match="tfoot/row">
      <tr class="tfoot"><xsl:apply-templates select="column"/></tr>
   </xsl:template>

   <xsl:template match="row">
      <xsl:if test="position() mod 2">
         <xsl:call-template name="odd-row"/>
      </xsl:if>
      <xsl:if test="not(position() mod 2)">
         <xsl:call-template name="even-row"/>
      </xsl:if>
   </xsl:template>

   <xsl:template name="odd-row">
      <tr class="odd"><xsl:apply-templates select="column"/></tr>
   </xsl:template>
   
   <xsl:template name="even-row">
      <tr class="even"><xsl:apply-templates select="column"/></tr>
   </xsl:template>

   <xsl:template match="tbody/row/column | tfoot/row/column">
      <xsl:element name="td">
         <xsl:if test="@class=true()">
            <xsl:attribute name="class">
               <xsl:value-of select="@class"/>
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
               <xsl:variable name="column_position"><xsl:value-of select="position()"/></xsl:variable>
               <xsl:text>text-align: </xsl:text><xsl:value-of select="ancestor::tgroup/child::columns[$column_position + 0 - 0]/attribute::align"/><xsl:text>;</xsl:text>
            </xsl:otherwise>
         </xsl:choose>
         </xsl:attribute>
         <xsl:if test="@span=true()">
            <xsl:attribute name="colspan"><xsl:value-of select="@span"/></xsl:attribute>
         </xsl:if>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

   <xsl:template match="thead/row/column">
      <xsl:element name="th">
         <xsl:if test="@class=true()">
            <xsl:attribute name="class">
               <xsl:value-of select="@class"/>
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
               <xsl:variable name="column_position"><xsl:value-of select="position()"/></xsl:variable>
               <xsl:text>text-align: </xsl:text><xsl:value-of select="ancestor::tgroup/child::columns[$column_position + 0 - 0]/attribute::align"/><xsl:text>;</xsl:text>
            </xsl:otherwise>
         </xsl:choose>
         </xsl:attribute>
         <xsl:if test="@span=true()">
            <xsl:attribute name="colspan"><xsl:value-of select="@span"/></xsl:attribute>
         </xsl:if>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- insert stop character -->
   <!-- =============================================================== -->

   <xsl:template match="stop">
      <img src="{$path-name}{$image-folder}svg/full-stop.svg" title="stop" alt="stop"/>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- handling of SmartQuotes -->
   <!-- =============================================================== -->

   <xsl:template match="q" mode="heading">&#x0022;<xsl:apply-templates/>&#x0022;</xsl:template>

   <xsl:template match="q">&#x201C;<xsl:apply-templates/>&#x201D;</xsl:template>

   <xsl:template match="sq" mode="heading">'<xsl:apply-templates/>'</xsl:template>

   <xsl:template match="sq">&#x2018;<xsl:apply-templates/>&#x2019;</xsl:template>

   <xsl:template match="apos" mode="heading">'</xsl:template>

   <xsl:template match="apos">&#x2019;</xsl:template>

</xsl:stylesheet> 
