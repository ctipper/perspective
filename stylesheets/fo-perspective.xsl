<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:rx="http://www.renderx.com/XSL/Extensions"
                xmlns:xlink="http://www.w3.org/1999/xlink">

   <xsl:output method="xml" 
               encoding="UTF-8" 
               media-type="text/xml" 
               indent="yes"/>

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

   <!-- =============================================================== -->
   <!-- FO specific parameters -->
   <!-- =============================================================== -->

   <xsl:param name="fo-processor">xep</xsl:param>           <!-- XEP or FOP output -->

   <xsl:param name="body.width">16</xsl:param>              <!-- units are cm -->

   <xsl:param name="color.top">#BBE4FF</xsl:param>          <!-- Light Blue -->
   <xsl:param name="color.theme">#BBE4FF</xsl:param>        <!-- Light Blue -->
   <xsl:param name="color.light-theme">#DDF2FF</xsl:param>  <!-- Lighter Blue -->
   <xsl:param name="color.counterpoint">#000000</xsl:param> <!-- Black -->
   <xsl:param name="color.link">#197fCC</xsl:param>         <!-- Darker Blue -->

   <xsl:param name="font.family.serif">Times</xsl:param>
   <xsl:param name="font.family.sans">Helvetica</xsl:param>
   <xsl:param name="font.family.mono">Courier</xsl:param>

   <xsl:param name="font.body.size">12pt</xsl:param>
   <xsl:param name="font.body.height">140%</xsl:param>
   <xsl:param name="font.body.after">6pt</xsl:param>
   <xsl:param name="font.bodyx.size">10pt</xsl:param>
   <xsl:param name="font.bodyx.height">140%</xsl:param>
   <xsl:param name="font.bodyx.after">3pt</xsl:param>
   <xsl:param name="font.literal.size">10pt</xsl:param>
   <xsl:param name="font.literal.height">140%</xsl:param>
   <xsl:param name="font.caption.size">10pt</xsl:param>
   <xsl:param name="font.caption.height">12pt</xsl:param>
   <xsl:param name="font.table.size">10pt</xsl:param>
   <xsl:param name="font.table.height">13.33pt</xsl:param>
   <xsl:param name="font.footnote.size">7pt</xsl:param>
   <xsl:param name="font.footnote.height">100%</xsl:param>
   <xsl:param name="font.foottext.size">10pt</xsl:param>
   <xsl:param name="font.foottext.height">140%</xsl:param>
   <xsl:param name="font.copyright.size">9pt</xsl:param>
   <xsl:param name="font.heading1.size">20pt</xsl:param>
   <xsl:param name="font.heading1.height">120%</xsl:param>
   <xsl:param name="font.heading1.before">6pt</xsl:param>
   <xsl:param name="font.heading1.after">6pt</xsl:param>
   <xsl:param name="font.heading2.size">14pt</xsl:param>
   <xsl:param name="font.heading2.height">120%</xsl:param>
   <xsl:param name="font.heading2.before">3pt</xsl:param>
   <xsl:param name="font.heading2.after">3pt</xsl:param>
   <xsl:param name="font.heading3.size">12pt</xsl:param>
   <xsl:param name="font.heading3.height">120%</xsl:param>
   <xsl:param name="font.heading3.before">6pt</xsl:param>
   <xsl:param name="font.heading3.after">3pt</xsl:param>
   <xsl:param name="font.dropcap.size">36pt</xsl:param>
   <xsl:param name="font.dropcap.height">26pt</xsl:param>
   <xsl:param name="font.dropcap.altitude">28pt</xsl:param>
   <xsl:param name="font.dropcap.depth">0pt</xsl:param>

   <!-- =============================================================== -->
   <!-- match root element -->
   <!-- =============================================================== -->

   <xsl:template match="/">
      <xsl:call-template name="fo-out"/>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- process main document -->  
   <!-- =============================================================== -->

   <xsl:template name="fo-out">
      <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" language="en" country="GB">
         <xsl:if test="$fo-processor='xep'">
            <xsl:call-template name="meta-info"/>
         </xsl:if>
         
         <fo:layout-master-set>
            <fo:simple-page-master master-name="first-page"
                                   page-height="29.7cm" 
                                   page-width="21cm">
               <fo:region-body margin-top="2.5cm"
                               margin-bottom="2.8cm"
                               margin-left="2.5cm"
                               margin-right="2.5cm"/>
               <fo:region-before region-name="first-page-header" precedence="true" extent="2.2cm"/>
               <fo:region-after region-name="page-footer" 
                                precedence="true" 
                                extent="2.5cm"/>
               <fo:region-start extent="2.2cm"/>
               <fo:region-end extent="2.2cm"/>
            </fo:simple-page-master>

            <fo:simple-page-master master-name="page"
                                   page-height="29.7cm" 
                                   page-width="21cm">
               <fo:region-body margin-top="2.5cm"
                               margin-bottom="2.8cm"
                               margin-left="2.5cm"
                               margin-right="2.5cm"/>
               <fo:region-before region-name="page-header" precedence="true" extent="2.2cm"/>
               <fo:region-after region-name="page-footer" 
                                precedence="true" 
                                extent="2.5cm"/>
               <fo:region-start extent="2.2cm"/>
               <fo:region-end extent="2.2cm"/>
            </fo:simple-page-master>
            
            <fo:simple-page-master master-name="last-page"
                                   page-height="29.7cm" 
                                   page-width="21cm">
               <fo:region-body margin-top="2.5cm"
                               margin-bottom="2.8cm"
                               margin-left="2.5cm"
                               margin-right="2.5cm"/>
               <fo:region-before region-name="page-header" precedence="true" extent="2.2cm"/>
               <fo:region-after region-name="last-footer" 
                                precedence="true" 
                                extent="2.5cm"/>
               <fo:region-start extent="2.2cm"/>
               <fo:region-end extent="2.2cm"/>
            </fo:simple-page-master>

            <fo:page-sequence-master master-name="document-sequence">
               <fo:repeatable-page-master-alternatives>
                  <fo:conditional-page-master-reference master-reference="first-page" page-position="first"/>
                  <fo:conditional-page-master-reference master-reference="page" odd-or-even="odd"/>
                  <fo:conditional-page-master-reference master-reference="page" odd-or-even="even"/>
                  <fo:conditional-page-master-reference master-reference="last-page" page-position="last"/>
               </fo:repeatable-page-master-alternatives>
            </fo:page-sequence-master>
            
         </fo:layout-master-set>

         <fo:page-sequence master-reference="document-sequence"
                           force-page-count="no-force">

            <fo:static-content flow-name="first-page-header">
               <fo:block> <!-- background-color="{$color.top}" -->
                  <fo:table table-layout="fixed">
                     <fo:table-column column-number="1" column-width="21cm"/>
                     <fo:table-body>
                        <fo:table-row height="2.2cm">
                           <fo:table-cell>
                              <fo:block><xsl:text> </xsl:text></fo:block>
                           </fo:table-cell>
                        </fo:table-row>
                     </fo:table-body>
                  </fo:table>
               </fo:block>
            </fo:static-content>

            <fo:static-content flow-name="page-header">
               <fo:block> <!-- background-color="{$color.top}" -->
                  <fo:table table-layout="fixed">
                     <fo:table-column column-number="1" column-width="18.5cm"/>
                     <fo:table-column column-number="2" column-width="2.5cm"/>
                     <fo:table-body>
                        <fo:table-row height="1.4cm">
                           <fo:table-cell number-columns-spanned="2">
                              <fo:block><xsl:text> </xsl:text></fo:block>
                           </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row height="0.8cm">
                           <fo:table-cell>
                              <xsl:apply-templates select="document/info/title" mode="header"/>
                           </fo:table-cell>
                           <fo:table-cell>
                              <fo:block><xsl:text> </xsl:text></fo:block>
                           </fo:table-cell>
                        </fo:table-row>
                     </fo:table-body>
                  </fo:table>
               </fo:block>
            </fo:static-content>

            <fo:static-content flow-name="page-footer">
               <fo:table table-layout="fixed">
                  <fo:table-column column-number="1" column-width="1.8cm"/>
                  <fo:table-column column-number="2" column-width="17.4cm"/>
                  <fo:table-column column-number="3" column-width="1.8cm"/>
                  <fo:table-body>
                     <fo:table-row height="2cm">
                        <fo:table-cell>
                           <fo:block><xsl:text> </xsl:text></fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                           <fo:block text-align="center"
                                     vertical-align="middle">
                              <fo:inline font-size="{$font.body.size}" 
                                         font-family="{$font.family.serif}">
                                 <fo:page-number/>
                              </fo:inline>
                           </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                           <fo:block text-align="center"><xsl:text> </xsl:text> 
                              <!-- room for 1.8cm x 2cm widget -->
                           </fo:block>
                        </fo:table-cell>
                     </fo:table-row>
                  </fo:table-body>
               </fo:table>
            </fo:static-content>

            <!-- =============================================================== -->
            <!-- xep 4.3 build 20050415 does not support page=last -->
            <!-- To embed copyright notice in footer uncomment following -->
            <!-- apply-templates and remove copyright from document template -->
            <!-- =============================================================== -->

            <fo:static-content flow-name="last-footer">
               <fo:table table-layout="fixed">
                  <fo:table-column column-number="1" column-width="1.8cm"/>
                  <fo:table-column column-number="2" column-width="8.2cm"/>
                  <fo:table-column column-number="3" column-width="1cm"/>
                  <fo:table-column column-number="4" column-width="8.2cm"/>
                  <fo:table-column column-number="5" column-width="1.8cm"/>
                  <fo:table-body>
                     <fo:table-row height="2cm">
                        <fo:table-cell>
                           <fo:block><xsl:text> </xsl:text></fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                           <!-- <xsl:apply-templates select="document/info/copyright"/> -->
                           <fo:block><xsl:text> </xsl:text></fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                           <fo:block text-align="center"
                                     vertical-align="middle">
                              <fo:inline font-size="{$font.body.size}" 
                                         font-family="{$font.family.serif}">
                                 <fo:page-number/>
                              </fo:inline>
                           </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                           <fo:block text-align="right"><xsl:text> </xsl:text></fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                           <fo:block text-align="center">
                              <!-- room for 1cm x 2cm widget -->
                              <xsl:text> </xsl:text> 
                           </fo:block>
                        </fo:table-cell>
                     </fo:table-row>
                  </fo:table-body>
               </fo:table>
            </fo:static-content>

            <fo:flow flow-name="xsl-region-body">
               <xsl:apply-templates/>
            </fo:flow>

         </fo:page-sequence>

      </fo:root>
   </xsl:template>

   <xsl:template name="meta-info">
      <rx:meta-info xmlns:rx="http://www.renderx.com/XSL/Extensions">
         <xsl:element name="rx:meta-field">
            <xsl:attribute name="name">author</xsl:attribute>
            <xsl:attribute name="value"><xsl:value-of select="//info/author"/></xsl:attribute>
         </xsl:element>
         <xsl:element name="rx:meta-field">
            <xsl:attribute name="name">creator</xsl:attribute>
            <xsl:attribute name="value">perspective XSL Stylesheets V2.1</xsl:attribute>
         </xsl:element>
         <xsl:element name="rx:meta-field">
            <xsl:attribute name="name">title</xsl:attribute>
            <xsl:attribute name="value"><xsl:apply-templates select="//info/title" mode="meta-info"/></xsl:attribute>
         </xsl:element>
         <xsl:element name="rx:meta-field">
            <xsl:attribute name="name">subject</xsl:attribute>
            <xsl:attribute name="value"><xsl:apply-templates select="//info/subtitle" mode="meta-info"/></xsl:attribute>
         </xsl:element>
         <xsl:element name="rx:meta-field">
            <xsl:attribute name="name">keywords</xsl:attribute>
            <xsl:attribute name="value"><xsl:value-of select="//info/keywords"/></xsl:attribute>
         </xsl:element>
      </rx:meta-info>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- process document -->
   <!-- =============================================================== -->

   <xsl:template match="document">
      <xsl:apply-templates select="info/title"/>
      <xsl:apply-templates select="info/subtitle"/>
      <xsl:apply-templates select="info/author"/>
      <xsl:apply-templates select="info/date"/>
      <xsl:apply-templates select="info/introduction"/>
      <xsl:apply-templates select="info/revhistory"/>
      <xsl:apply-templates select="body"/>
      <xsl:apply-templates select="bibliography"/>
      <xsl:apply-templates select="info/copyright" mode="footnote"/>
   </xsl:template>
   
   <xsl:template match="info/author">
      <fo:block font-family="{$font.family.sans}"
                font-size="11pt"
                font-style="italic"
                space-after="3pt">
         by <xsl:value-of select="."/>
         &lt;<fo:basic-link external-destination="url(mailto:{$email-address})" 
                            color="{$color.link}"><xsl:value-of select="$email-address"/>
         </fo:basic-link>&gt;
      </fo:block>
   </xsl:template>

   <xsl:template match="info/copyright">
      <fo:block font-family="{$font.family.serif}"
                font-size="{$font.copyright.size}"
                vertical-align="middle">
         <xsl:text>Copyright © </xsl:text>
         <xsl:value-of select="child::year"/><xsl:text> </xsl:text>
         <xsl:value-of select="child::owner"/>
      </fo:block>
   </xsl:template>

   <xsl:template match="info/copyright" mode="footnote">
      <fo:block>
         <fo:footnote><fo:inline><xsl:text> </xsl:text></fo:inline>
         <fo:footnote-body>
            <fo:block font-family="{$font.family.serif}"
                      font-size="{$font.copyright.size}">
               <xsl:text>Copyright © </xsl:text>
               <xsl:value-of select="child::year"/><xsl:text> </xsl:text>
               <xsl:value-of select="child::owner"/>
            </fo:block>
         </fo:footnote-body>
         </fo:footnote>
      </fo:block>
   </xsl:template>

   <xsl:template match="info/introduction">
      <fo:table table-layout="fixed" width="100%">
         <fo:table-column column-width="proportional-column-width(1)"/>
         <fo:table-column column-width="proportional-column-width(4)" />
         <fo:table-column column-width="proportional-column-width(1)"/>
         <fo:table-body>
            <fo:table-row>
               <fo:table-cell>
                  <fo:block><xsl:text> </xsl:text></fo:block>
               </fo:table-cell>
               <fo:table-cell>
                  <fo:block width="100%"
                            text-align="left"
                            margin-top="10pt"
                            margin-bottom="10pt"
                            padding="1em"
                            border="1px solid black">
                     <xsl:choose>
                        <xsl:when test="name(child::node())='p'">
                           <xsl:apply-templates select="p" mode="emptypara"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <fo:block font-family="{$font.family.sans}"
                                     font-size="{$font.caption.size}"
                                     font-style="italic"
                                     space-after="3pt">
                              <fo:inline font-weight="bold">Abstract:</fo:inline><xsl:text> </xsl:text><xsl:apply-templates/>
                           </fo:block>
                        </xsl:otherwise>
                     </xsl:choose>
                  </fo:block>
               </fo:table-cell>
               <fo:table-cell>
                  <fo:block><xsl:text> </xsl:text></fo:block>
               </fo:table-cell>
            </fo:table-row>
         </fo:table-body>
      </fo:table>
   </xsl:template>

   <xsl:template match="introduction/p" mode="emptypara">
      <xsl:if test="position()=1">
         <fo:block font-family="{$font.family.sans}"
                   font-size="{$font.caption.size}"
                   font-style="italic"
                   space-after="3pt">
            <fo:inline font-weight="bold">Abstract:</fo:inline><xsl:text> </xsl:text><xsl:apply-templates/>
         </fo:block>
      </xsl:if>
      <xsl:if test="position()&gt;1">
         <fo:block font-family="{$font.family.sans}"
                   font-size="{$font.caption.size}"
                   font-style="italic"
                   space-after="3pt">
            <xsl:apply-templates/>
         </fo:block>
      </xsl:if>
   </xsl:template>

   <xsl:template match="info/date">
      <fo:block font-family="{$font.family.sans}"
                font-size="{$font.bodyx.size}"
                line-height="{$font.bodyx.height}"
                space-after="{$font.bodyx.after}">
         <xsl:apply-templates/>
      </fo:block>
   </xsl:template>

   <xsl:template match="bloginfo/date">
      <fo:block font-family="{$font.family.sans}"
                font-size="{$font.body.size}"
                line-height="{$font.body.height}"
                space-after="{$font.body.after}">
         <xsl:apply-templates/>
      </fo:block>
   </xsl:template>

   <xsl:template match="info/title | bloginfo/title | section/title">
      <fo:block font-family="{$font.family.sans}"
                font-size="{$font.heading1.size}"
                line-height="{$font.heading1.height}"
                space-before="{$font.heading1.before}"
                space-after="{$font.heading1.after}">
         <xsl:if test="parent::section">
            <xsl:call-template name="sect-number"/>
         </xsl:if>
         <xsl:apply-templates/>
      </fo:block>
   </xsl:template>

   <xsl:template name="sect-number">
      <xsl:if test="$sect-number='on'">
         <xsl:if test="parent::section">
            <xsl:number level="any" count="//section" format="1"/>
         </xsl:if>
      </xsl:if>
      <xsl:text> </xsl:text>
   </xsl:template>

   <xsl:template match="info/title" mode="header">
      <fo:block font-family="{$font.family.sans}"
                font-size="{$font.body.size}"
                text-align="right">
         <xsl:apply-templates/>
      </fo:block>
   </xsl:template>
   
   <xsl:template match="info/title" mode="meta-info">
      <xsl:apply-templates mode="meta-info"/>
   </xsl:template>

   <xsl:template match="info/subtitle">
      <fo:block font-family="{$font.family.sans}"
                font-size="{$font.heading2.size}"
                space-after="3pt">
         <xsl:apply-templates/>
      </fo:block>
   </xsl:template>

   <xsl:template match="info/subtitle" mode="meta-info">
      <xsl:apply-templates mode="meta-info"/>
   </xsl:template>

   <xsl:template match="body">
      <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template match="section">
      <xsl:apply-templates/>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- blog entries -->
   <!-- =============================================================== -->

   <xsl:template match="blog">
      <xsl:apply-templates select="bloginfo/date"/>
      <xsl:apply-templates select="bloginfo/title"/>
      <xsl:apply-templates/>
      <xsl:element name="fo:block">
         <xsl:attribute name="font-family"><xsl:value-of select="$font.family.sans"/></xsl:attribute>
         <xsl:attribute name="font-size"><xsl:value-of select="$font.caption.size"/></xsl:attribute>
         <xsl:attribute name="line-height"><xsl:value-of select="$font.caption.height"/></xsl:attribute>
         <fo:basic-link external-destination="url({$site-url}{$file-name}.html#{@id})" color="{$color.link}">Permalink</fo:basic-link>
      </xsl:element>
      <xsl:if test="position()!=last()">
         <fo:block text-align-last="justify"
                   page-break-after="always">
            <fo:leader leader-pattern="space"
                       rule-thickness="0.5pt" />
         </fo:block>
      </xsl:if>
   </xsl:template>

   <xsl:template match="bloginfo">
   </xsl:template>

   <!-- =============================================================== -->
   <!-- horizontal rule -->
   <!-- =============================================================== -->

   <xsl:template match="hr">
      <fo:block text-align-last="justify">
         <fo:leader leader-pattern="rule"
                    rule-thickness="0.5pt" />
      </fo:block>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- Body <p> default is "bodyText" -->
   <!-- New version with context-sensitive Drop Caps -->
   <!-- =============================================================== -->

   <xsl:template match="p">
      <xsl:element name="fo:block">
         <xsl:choose>
            <xsl:when test="@align=true()">
               <xsl:attribute name="text-align"><xsl:value-of select="string(@align)"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="text-align">justify</xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:choose>
            <xsl:when test="@class='bodyTextItalic'">
               <xsl:attribute name="font-family"><xsl:value-of select="$font.family.serif"/></xsl:attribute>
               <xsl:attribute name="font-size"><xsl:value-of select="$font.body.size"/></xsl:attribute>
               <xsl:attribute name="font-style">italic</xsl:attribute>
               <xsl:attribute name="line-height"><xsl:value-of select="$font.body.height"/></xsl:attribute>
            </xsl:when>
            <xsl:when test="@class='lightText'">
               <xsl:attribute name="font-family"><xsl:value-of select="$font.family.serif"/></xsl:attribute>
               <xsl:attribute name="color">#444444</xsl:attribute>
               <xsl:attribute name="line-height"><xsl:value-of select="$font.body.height"/></xsl:attribute>
            </xsl:when>
            <xsl:when test="@class='lightTextItalic'">
               <xsl:attribute name="font-family"><xsl:value-of select="$font.family.serif"/></xsl:attribute>
               <xsl:attribute name="font-size"><xsl:value-of select="$font.body.size"/></xsl:attribute>
               <xsl:attribute name="color">#444444</xsl:attribute>
               <xsl:attribute name="font-style">italic</xsl:attribute>
               <xsl:attribute name="line-height"><xsl:value-of select="$font.body.height"/></xsl:attribute>
            </xsl:when>
            <xsl:when test="@class='blockText'">
               <xsl:attribute name="font-family"><xsl:value-of select="$font.family.sans"/></xsl:attribute>
               <xsl:attribute name="font-size"><xsl:value-of select="$font.body.size"/></xsl:attribute>
               <xsl:attribute name="font-style">italic</xsl:attribute>
               <xsl:attribute name="line-height"><xsl:value-of select="$font.body.height"/></xsl:attribute>
            </xsl:when>
            <xsl:when test="@class='blockItalic'">
               <xsl:attribute name="font-family"><xsl:value-of select="$font.family.sans"/></xsl:attribute>
               <xsl:attribute name="font-size"><xsl:value-of select="$font.body.size"/></xsl:attribute>
               <xsl:attribute name="font-style">italic</xsl:attribute>
               <xsl:attribute name="line-height"><xsl:value-of select="$font.body.height"/></xsl:attribute>
            </xsl:when>
            <xsl:when test="@class='Notice'">
               <xsl:attribute name="font-family"><xsl:value-of select="$font.family.sans"/></xsl:attribute>
               <xsl:attribute name="font-size"><xsl:value-of select="$font.heading3.size"/></xsl:attribute>
               <xsl:attribute name="line-height"><xsl:value-of select="$font.heading3.height"/></xsl:attribute>
               <xsl:attribute name="space-after"><xsl:value-of select="$font.heading3.after"/></xsl:attribute>
            </xsl:when>
            <xsl:when test="@class='date'">
               <xsl:attribute name="font-family"><xsl:value-of select="$font.family.sans"/></xsl:attribute>
               <xsl:attribute name="font-size"><xsl:value-of select="$font.bodyx.size"/></xsl:attribute>
               <xsl:attribute name="font-style">italic</xsl:attribute>
               <xsl:attribute name="line-height"><xsl:value-of select="$font.bodyx.height"/></xsl:attribute>
               <xsl:attribute name="space-after"><xsl:value-of select="$font.bodyx.after"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="font-family"><xsl:value-of select="$font.family.serif"/></xsl:attribute>
               <xsl:attribute name="font-size"><xsl:value-of select="$font.body.size"/></xsl:attribute>
               <xsl:attribute name="line-height"><xsl:value-of select="$font.body.height"/></xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:attribute name="hyphenate">true</xsl:attribute>
         <xsl:attribute name="space-after"><xsl:value-of select="$font.body.after"/></xsl:attribute>
         <xsl:attribute name="line-height-shift-adjustment">disregard-shifts</xsl:attribute>
         <xsl:attribute name="intrusion-displace">line</xsl:attribute>
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
      <fo:float float="start">
         <fo:block font-family="{$font.family.serif}"
                   font-size="{$font.dropcap.size}" 
                   line-height="{$font.dropcap.height}" 
                   text-altitude="{$font.dropcap.altitude}" 
                   text-depth="{$font.dropcap.depth}"
                   margin-right="1pt"
                   padding="1pt">
            <xsl:value-of select="substring(text(),1,1)"/>
         </fo:block>
      </fo:float>
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
                            ' ')"/>
      <xsl:apply-templates select="child::node()/following-sibling::node()"/>
   </xsl:template>

   <xsl:template name="drop-cap-quote">
      <xsl:variable name="this-quote"><xsl:value-of select="child::q[1]"/></xsl:variable>
      <fo:float float="start">
         <fo:block font-family="{$font.family.serif}"
                   font-size="{$font.dropcap.size}" 
                   line-height="{$font.dropcap.height}" 
                   text-altitude="{$font.dropcap.altitude}" 
                   text-depth="{$font.dropcap.depth}"
                   margin-right="1pt"
                   padding="1pt">
            &#x201C;<xsl:value-of select="substring($this-quote,1,1)"/>
         </fo:block>
      </fo:float>
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
      <fo:float float="start">
         <fo:block font-family="{$font.family.serif}"
                   font-size="{$font.dropcap.size}" 
                   line-height="{$font.dropcap.height}" 
                   text-altitude="{$font.dropcap.altitude}" 
                   text-depth="{$font.dropcap.depth}"
                   margin-right="1pt"
                   padding="1pt">
            <xsl:value-of select="substring($this-href,1,1)"/>
         </fo:block>
      </fo:float>
      <xsl:variable name="cap-text">
         <xsl:value-of select="substring(substring-before($this-href,' '),2,string-length(substring-before($this-href,' ')))"
                       disable-output-escaping="yes"/>
      </xsl:variable>
      <xsl:element name="fo:basic-link">
         <xsl:attribute name="external-destination">url(<xsl:value-of select="child::a[1]/attribute::href"/>)</xsl:attribute>
         <xsl:attribute name="color"><xsl:value-of select="$color.link"/></xsl:attribute>
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

   <xsl:template match="p" mode="item">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="byline">
      <xsl:element name="fo:block">
         <xsl:choose>
            <xsl:when test="@align=true()">
               <xsl:attribute name="text-align"><xsl:value-of select="string(@align)"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="text-align">justify</xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:attribute name="font-family"><xsl:value-of select="$font.family.serif"/></xsl:attribute>
         <xsl:attribute name="font-size"><xsl:value-of select="$font.body.size"/></xsl:attribute>
         <xsl:attribute name="font-style">italic</xsl:attribute>
         <xsl:attribute name="line-height"><xsl:value-of select="$font.body.height"/></xsl:attribute>
         <xsl:attribute name="hyphenate">true</xsl:attribute>
         <xsl:attribute name="space-after"><xsl:value-of select="$font.body.after"/></xsl:attribute>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- indents quoted block -->
   <!-- =============================================================== -->

   <xsl:template match="blockquote | epigraph">
      <fo:block font-family="{$font.family.serif}"
                font-size="{$font.body.size}"
                line-height="{$font.body.height}"
                font-style="italic"
                start-indent="15pt"
                end-indent="15pt"
                language="en"
                country="GB"
                hyphenate="true">
         <xsl:apply-templates/>
      </fo:block>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- center on a new line -->
   <!-- =============================================================== -->

   <xsl:template match="center">
      <fo:block font-family="{$font.family.serif}" 
                font-size="{$font.body.size}"
                text-align="center"
                line-height="{$font.body.height}"
                space-after="{$font.body.after}"
                language="en"
                country="GB"
                hyphenate="true">
         <xsl:apply-templates/>
      </fo:block>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- preformatted text -->
   <!-- =============================================================== -->

   <xsl:template match="pre">
      <fo:block font-family="{$font.family.mono}" 
                font-size="{$font.literal.size}"
                line-height="{$font.literal.height}"
                space-after="{$font.body.after}"
                white-space="pre"
                margin="3pt"
                padding="0.5em"
                language="en"
                country="GB"
                hyphenate="true">
<!--            border="1px solid {$color.counterpoint}"
                background-color="{$color.theme}"
-->
         <xsl:apply-templates/>
      </fo:block>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- section heading -->
   <!-- =============================================================== -->

   <xsl:template match="sub-heading">
      <fo:block font-family="{$font.family.sans}"
                font-size="{$font.heading2.size}"
                line-height="{$font.heading2.height}"
                space-before="{$font.heading2.before}"
                space-after="{$font.heading2.after}"
                keep-with-next.within-page="always">
         <xsl:apply-templates/>
      </fo:block>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- rich-text styles: italic, bold, underline and superscript -->
   <!-- =============================================================== -->

   <xsl:template match="i">
      <fo:inline font-style="italic">
         <xsl:apply-templates/>
      </fo:inline>
   </xsl:template>

   <xsl:template match="b">
      <fo:inline font-weight="bold">
         <xsl:apply-templates/>
      </fo:inline>
   </xsl:template>

   <xsl:template match="u">
      <fo:inline text-decoration="underline">
         <xsl:apply-templates/>
      </fo:inline>
   </xsl:template>

   <xsl:template match="sup">
      <fo:inline baseline-shift="super"
                 font-size="{$font.footnote.size}"
                 line-height="{$font.footnote.height}">
         <xsl:apply-templates/>
      </fo:inline>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- tele-type font -->
   <!-- =============================================================== -->

   <xsl:template match="tt">
      <fo:inline font-family="{$font.family.mono}" font-size="{$font.literal.size}"><xsl:apply-templates/></fo:inline>
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
   <!-- handle ordered lists in the form
        <enumerate>
           <item>...</item>
           <item>...</item>
        </enumerate>                       -->
   <!-- =============================================================== -->

   <xsl:template match="enumerate | itemize">
      <fo:list-block provisional-distance-between-starts="0.62cm">
         <xsl:apply-templates select="item"/>
      </fo:list-block>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- handle bulleted lists in the form
        <itemize>
           <item>...</item>
           <item>...</item>
        </itemize>                          -->
   <!-- =============================================================== -->

   <!-- =============================================================== -->
   <!-- for both types of itemization -->
   <!-- =============================================================== -->

   <xsl:template match="item">
      <fo:list-item relative-align="baseline">
         <fo:list-item-label end-indent="label-end()">
            <fo:block font-family="{$font.family.serif}"
                      font-size="{$font.body.size}"
                      line-height="{$font.body.height}">
               <xsl:choose>
                  <xsl:when test="parent::enumerate">
                     <xsl:choose>
                        <xsl:when test="parent::enumerate/attribute::style">
                           <xsl:choose>
                              <xsl:when test="parent::enumerate/attribute::style='a'">
                                 <xsl:number level="single" count="item" format="a"/>.
                              </xsl:when>
                              <xsl:when test="parent::enumerate/attribute::style='A'">
                                 <xsl:number level="single" count="item" format="A"/>.
                              </xsl:when>
                              <xsl:when test="parent::enumerate/attribute::style='i'">
                                 <xsl:number level="single" count="item" format="i"/>.
                              </xsl:when>
                              <xsl:when test="parent::enumerate/attribute::style='I'">
                                 <xsl:number level="single" count="item" format="I"/>.
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:number level="single" count="item" format="1"/>.
                              </xsl:otherwise>
                           </xsl:choose>                
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:number level="single" count="item" format="1"/>.
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:when>
                  <xsl:when test="parent::itemize">
                     <fo:inline font-family="Symbol" color="{$color.counterpoint}">
                        <xsl:text disable-output-escaping="yes">&amp;#x2022;</xsl:text>
                     </fo:inline>
                  </xsl:when>
                  <xsl:otherwise>?</xsl:otherwise>
               </xsl:choose>
            </fo:block>
         </fo:list-item-label>
         <fo:list-item-body start-indent="body-start()">
            <xsl:apply-templates/>
         </fo:list-item-body>
      </fo:list-item>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- 
        Handle LaTeX style bibliography entries 
        
        syntax is <cite>label</cite>                                (i)
        
        and then the bibliography database is a simple enumeration
        
        <bibliography>
           <bibitem tag="label">...</bibitem>                      (ii)
           <bibitem tag="another-label">...</bibitem>
           ...
        </bibliography>
        
        It is up to the document author to reconcile labels in cases (i) and (ii) -->
   <!-- =============================================================== -->

   <xsl:template match="bibliography">
      <fo:block font-family="{$font.family.sans}" 
                font-size="{$font.heading2.size}"
                text-align="justify"
                line-height="{$font.heading2.height}"
                language="en"
                country="GB"
                hyphenate="true"
                space-after="3pt"
                page-break-before="always">
         <xsl:text>Bibliography</xsl:text>
      </fo:block>
      <xsl:apply-templates/>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- creates a citation entry -->
   <!-- =============================================================== -->

   <xsl:template match="cite">
      <xsl:variable name="citeref" select="."/>
      <xsl:text>(</xsl:text>
      <xsl:element name="fo:basic-link">
         <xsl:attribute name="internal-destination">
            <xsl:value-of select="."/>
         </xsl:attribute>
         <xsl:attribute name="color">black</xsl:attribute>
         <xsl:value-of select="."/><xsl:text>, </xsl:text><xsl:value-of select="//bibliography/bibitem[@label=$citeref]/year"/>
      </xsl:element>
      <xsl:text>)</xsl:text>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- outputs the bibliography item for both a book and an article -->
   <!-- =============================================================== -->

   <xsl:template match="bibitem[@type='book']">
      <fo:block font-family="{$font.family.serif}" 
                font-size="{$font.body.size}"
                text-align="justify"
                line-height="{$font.body.height}"
                language="en"
                country="GB"
                hyphenate="true"
                space-after="{$font.body.after}">
         <fo:inline id="{@label}"><xsl:text> </xsl:text></fo:inline>
         <!-- [<xsl:value-of select="string(@label)"/>] -->
         <xsl:apply-templates select="author" mode="bib"/>
         <xsl:if test="./editor"><xsl:text>ed. </xsl:text></xsl:if>
         <xsl:apply-templates select="editor" mode="bib"/>
         <xsl:text>(</xsl:text><xsl:apply-templates select="year" mode="bib"/><xsl:text>), </xsl:text>
         <xsl:apply-templates select="title" mode="bib"/>
         <xsl:apply-templates select="edition" mode="bib"/>
         <xsl:apply-templates select="publisher" mode="bib"/>
         <xsl:apply-templates select="note" mode="bib"/>
      </fo:block>
   </xsl:template>

   <xsl:template match="bibitem[@type='article']">
      <fo:block font-family="{$font.family.serif}" 
                font-size="{$font.body.size}"
                text-align="justify"
                line-height="{$font.body.height}"
                language="en"
                country="GB"
                hyphenate="true"
                space-after="{$font.body.after}">
         <fo:inline id="{@label}"><xsl:text> </xsl:text></fo:inline>
         <!-- [<xsl:value-of select="string(@label)"/>] -->
         <xsl:apply-templates select="author" mode="bib"/>
         <xsl:if test="./editor"><xsl:text>ed. </xsl:text></xsl:if>
         <xsl:apply-templates select="editor" mode="bib"/>
         <xsl:apply-templates select="month" mode="bib"/><xsl:text>, </xsl:text> 
         <xsl:apply-templates select="year" mode="bib"/><xsl:text>. </xsl:text>
         <xsl:apply-templates select="title" mode="bib"/>
         <xsl:apply-templates select="journal" mode="bib"/>
         <xsl:apply-templates select="note" mode="bib"/>
      </fo:block>
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

   <xsl:template match="bibitem/title" mode="bib"><fo:inline font-style="italic"><xsl:apply-templates/></fo:inline><xsl:text>, </xsl:text></xsl:template>

   <xsl:template match="bibitem/edition" mode="bib"><xsl:apply-templates/><xsl:text> edition, </xsl:text></xsl:template>

   <xsl:template match="bibitem/publisher" mode="bib"><xsl:apply-templates/><xsl:text>. </xsl:text></xsl:template>
   
   <xsl:template match="bibitem/journal" mode="bib"><xsl:apply-templates/><xsl:text>. </xsl:text></xsl:template>

   <xsl:template match="bibitem/note" mode="bib"><xsl:apply-templates/><xsl:text>.</xsl:text></xsl:template>

   <!-- =============================================================== -->
   <!-- handles href and name attributes of the a tag -->
   <!-- =============================================================== -->

   <xsl:template match="a[@href]">
      <xsl:choose>
         <xsl:when test="substring(@href,1,1)='#'">
            <fo:basic-link internal-destination="{substring-after(@href,'#')}"
                           color="{$color.link}">
               <xsl:apply-templates/>
            </fo:basic-link>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="@type=true()">
                  <!-- disable href extensions -->
                  <xsl:apply-templates/>
               </xsl:when>
               <xsl:otherwise>
                  <fo:basic-link external-destination="url({@href})"
                                 color="{$color.link}">
                     <xsl:apply-templates/>
                  </fo:basic-link>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="a[@name]">
      <fo:block id="{@name}"></fo:block>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- footnotes -->
   <!-- =============================================================== -->

   <xsl:template match="footnote">
      <xsl:choose>
         <xsl:when test="parent::column">
            <xsl:element name="fo:inline">
               <xsl:attribute name="id">brf.<xsl:value-of select="generate-id(.)" /></xsl:attribute>
               <xsl:attribute name="font-family"><xsl:value-of select="$font.family.serif"/></xsl:attribute>
               <xsl:attribute name="font-size"><xsl:value-of select="$font.footnote.size"/></xsl:attribute>
               <xsl:attribute name="baseline-shift">super</xsl:attribute>
               <xsl:attribute name="line-height"><xsl:value-of select="$font.footnote.height"/></xsl:attribute>
               <xsl:element name="fo:basic-link">
                  <xsl:attribute name="internal-destination">ftn.<xsl:value-of select="generate-id(.)" /></xsl:attribute>
                  <xsl:attribute name="color"><xsl:value-of select="$color.link"/></xsl:attribute>
                  <xsl:number level="any" count="column/footnote" from="table" format="a"/>
               </xsl:element>
            </xsl:element>
         </xsl:when>
         <xsl:otherwise> <!-- usually parent::p -->
            <fo:footnote>
               <xsl:element name="fo:inline">
                  <xsl:attribute name="id">brf.<xsl:value-of select="generate-id(.)" /></xsl:attribute>
                  <xsl:attribute name="font-family"><xsl:value-of select="$font.family.serif"/></xsl:attribute>
                  <xsl:attribute name="font-size"><xsl:value-of select="$font.footnote.size"/></xsl:attribute>
                  <xsl:attribute name="baseline-shift">super</xsl:attribute>
                  <xsl:attribute name="line-height"><xsl:value-of select="$font.footnote.height"/></xsl:attribute>
                  <xsl:element name="fo:basic-link">
                     <xsl:attribute name="internal-destination">ftn.<xsl:value-of select="generate-id(.)" /></xsl:attribute>
                     <xsl:attribute name="color"><xsl:value-of select="$color.link"/></xsl:attribute>
                     <xsl:number level="any" count="p/footnote | center/footnote | pre/footnote" format="1"/>
                  </xsl:element>
               </xsl:element>
               <fo:footnote-body>
                  <xsl:choose>
                     <xsl:when test="child::p">
                        <xsl:apply-templates select="p" mode="endnotes"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <fo:block font-family="{$font.family.serif}"
                                  font-size="{$font.foottext.size}"
                                  line-height="{$font.foottext.height}"
                                  text-align="left"
                                  font-weight="normal"
                                  font-style="normal"
                                  start-indent="0pt"
                                  end-indent="0pt"
                                  text-indent="0pt">
                           <xsl:element name="fo:inline">
                              <xsl:attribute name="id">ftn.<xsl:value-of select="generate-id(.)" /></xsl:attribute>
                              <xsl:attribute name="font-size"><xsl:value-of select="$font.footnote.size"/></xsl:attribute>
                              <xsl:attribute name="baseline-shift">super</xsl:attribute>
                              <xsl:attribute name="line-height"><xsl:value-of select="$font.footnote.height"/></xsl:attribute>
                              <xsl:element name="fo:basic-link">
                                 <xsl:attribute name="internal-destination">brf.<xsl:value-of select="generate-id(.)" /></xsl:attribute>
                                 <xsl:attribute name="color"><xsl:value-of select="$color.link"/></xsl:attribute>
                                 <xsl:number level="any" count="p/footnote | center/footnote | pre/footnote" format="1"/>
                              </xsl:element>
                           </xsl:element><xsl:text> </xsl:text>
                           <xsl:apply-templates/>
                        </fo:block>
                     </xsl:otherwise>
                  </xsl:choose>
               </fo:footnote-body>
            </fo:footnote>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="p" mode="endnotes">
      <fo:block font-family="{$font.family.serif}"
                font-size="{$font.foottext.size}"
                line-height="{$font.foottext.height}"
                text-align="left"
                font-weight="normal"
                start-indent="0pt"
                end-indent="0pt"
                text-indent="0pt">
         <xsl:if test="position()=1">
            <xsl:element name="fo:inline">
               <xsl:attribute name="id">ftn.<xsl:value-of select="generate-id(parent::footnote)" /></xsl:attribute>
               <xsl:attribute name="font-size"><xsl:value-of select="$font.footnote.size"/></xsl:attribute>
               <xsl:attribute name="baseline-shift">super</xsl:attribute>
               <xsl:attribute name="line-height"><xsl:value-of select="$font.footnote.height"/></xsl:attribute>
               <xsl:element name="fo:basic-link">
                  <xsl:attribute name="internal-destination">brf.<xsl:value-of select="generate-id(parent::footnote)" /></xsl:attribute>
                  <xsl:attribute name="color"><xsl:value-of select="$color.link"/></xsl:attribute>
                  <xsl:number level="any" count="p/footnote | center/footnote | pre/footnote" format="1"/>
               </xsl:element>
            </xsl:element><xsl:text> </xsl:text>
         </xsl:if>
         <xsl:apply-templates/>
      </fo:block>
   </xsl:template>
   
   <!-- =============================================================== -->
   <!-- generate table footnotes -->
   <!-- =============================================================== -->

   <xsl:template match="column/footnote" mode="footnote">
      <fo:block font-family="{$font.family.sans}"
                font-size="{$font.foottext.size}"
                line-height="{$font.foottext.height}"
                text-align="left"
                font-weight="normal">
         <xsl:element name="fo:inline">
            <xsl:attribute name="id">ftn.<xsl:value-of select="generate-id(.)" /></xsl:attribute>
            <xsl:attribute name="font-size"><xsl:value-of select="$font.footnote.size"/></xsl:attribute>
            <xsl:attribute name="baseline-shift">super</xsl:attribute>
            <xsl:attribute name="line-height"><xsl:value-of select="$font.footnote.height"/></xsl:attribute>
            <xsl:element name="fo:basic-link">
               <xsl:attribute name="internal-destination">brf.<xsl:value-of select="generate-id(.)" /></xsl:attribute>
               <xsl:attribute name="color"><xsl:value-of select="$color.link"/></xsl:attribute>
               <xsl:number level="any" count="column/footnote" from="table" format="a"/>
            </xsl:element>
         </xsl:element><xsl:text> </xsl:text>
         <xsl:apply-templates/>
      </fo:block>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- inserting graphics
        the figure is embedded in a table with an optional caption and 
        optional numbering format-number(...) converts pixels on basis 
        of 96dpi.                                                       -->
   <!-- =============================================================== -->

   <xsl:template match="img">
      <xsl:choose>
         <xsl:when test="@align='center' or @align=false()">
            <fo:block-container span="all">
               <xsl:choose>
                  <xsl:when test="@float='yes'">
                     <xsl:element name="fo:float">
                        <xsl:attribute name="float">before</xsl:attribute>
                        <xsl:call-template name="img-render"/>
                     </xsl:element>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:call-template name="img-render"/>
                  </xsl:otherwise>
               </xsl:choose>
            </fo:block-container>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="fo:float">
               <xsl:attribute name="float"><xsl:value-of select="@align"/></xsl:attribute>
               <xsl:attribute name="clear"><xsl:value-of select="@align"/></xsl:attribute>
               <xsl:call-template name="img-render"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <xsl:template name="img-render">
      <xsl:element name="fo:block">
         <xsl:attribute name="keep-together">always</xsl:attribute>
         <xsl:attribute name="text-align">center</xsl:attribute>
         <xsl:attribute name="margin">5pt 10pt</xsl:attribute>   <!-- padding -->
         <fo:block>
            <xsl:call-template name="insert-graphic">
               <xsl:with-param name="image"><xsl:value-of select="@src"/></xsl:with-param>
               <xsl:with-param name="extension"><xsl:if test="@format=true()"><xsl:value-of select="@format"/></xsl:if></xsl:with-param>
               <xsl:with-param name="pdfres"><xsl:if test="@pdfres=true()"><xsl:value-of select="@pdfres"/></xsl:if></xsl:with-param>
            </xsl:call-template>
         </fo:block>
         <xsl:choose>
            <xsl:when test="@align='center' or @align=false()">
               <xsl:apply-templates select="caption" mode="center"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:apply-templates select="caption" mode="side"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:element>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- insert graphic                                                  -->
   <!-- =============================================================== -->

   <xsl:template name="insert-graphic">
      <xsl:param name="image">image</xsl:param>
      <xsl:param name="extension">png</xsl:param>
      <xsl:param name="pdfres">false</xsl:param>
      <xsl:choose>
         <xsl:when test="contains(string($pdfres),'svg')">
            <xsl:element name="fo:external-graphic">
               <xsl:if test="$fo-processor='fop'">
                  <xsl:attribute name="src">url(<xsl:value-of select="$path-name"/><xsl:value-of select="$image-folder"/>svg/<xsl:value-of select="$image"/>.svg)</xsl:attribute>
                  <xsl:attribute name="content-width"><xsl:value-of select="format-number(@width * (2.54 div $resolution),'0.000')"/>cm</xsl:attribute>
                  <xsl:attribute name="content-height"><xsl:value-of select="format-number(@height * (2.54 div $resolution),'0.000')"/>cm</xsl:attribute>
               </xsl:if>
               <xsl:if test="$fo-processor='xep'">
                  <xsl:attribute name="src">url(<xsl:value-of select="$path-name"/><xsl:value-of select="$image-folder"/>svg/<xsl:value-of select="$image"/>.svg)</xsl:attribute>
                  <xsl:attribute name="content-width"><xsl:value-of select="format-number(@width * (2.54 div $resolution),'0.000')"/>cm</xsl:attribute>
                  <xsl:attribute name="content-height"><xsl:value-of select="format-number(@height * (2.54 div $resolution),'0.000')"/>cm</xsl:attribute>
               </xsl:if>
            </xsl:element>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="fo:external-graphic">
               <xsl:if test="$fo-processor='fop'">
                  <xsl:attribute name="src">url(<xsl:value-of select="$path-name"/><xsl:value-of select="$image-folder"/><xsl:if test="number($pdfres)"><xsl:value-of select="$pdfres"/>dpi/</xsl:if><xsl:value-of select="$image"/>.<xsl:value-of select="$extension" />)</xsl:attribute>
                  <xsl:attribute name="content-width"><xsl:value-of select="format-number(@width * (2.54 div $resolution),'0.000')"/>cm</xsl:attribute>
                  <xsl:attribute name="content-height"><xsl:value-of select="format-number(@height * (2.54 div $resolution),'0.000')"/>cm</xsl:attribute>
               </xsl:if>
               <xsl:if test="$fo-processor='xep'">
                  <xsl:attribute name="src">url(<xsl:value-of select="$path-name"/><xsl:value-of select="$image-folder"/><xsl:if test="number($pdfres)"><xsl:value-of select="$pdfres"/>dpi/</xsl:if><xsl:value-of select="$image"/>.<xsl:value-of select="$extension" />)</xsl:attribute>
                  <xsl:attribute name="content-width"><xsl:value-of select="format-number(@width * (2.54 div $resolution),'0.000')"/>cm</xsl:attribute>
                  <xsl:attribute name="content-height"><xsl:value-of select="format-number(@height * (2.54 div $resolution),'0.000')"/>cm</xsl:attribute>
               </xsl:if>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="caption" mode="center">
      <xsl:variable name="image-width"><xsl:value-of select="format-number(number(parent::img/attribute::width) * (2.54 div $resolution),'0.000')"/></xsl:variable>
      <xsl:element name="fo:block-container">
         <xsl:attribute name="width"><xsl:value-of select="$image-width"/>cm</xsl:attribute>
         <xsl:attribute name="start-indent"><xsl:value-of select="format-number((number($body.width) - number($image-width)) div 2,'0.000')"/>cm</xsl:attribute>
         <xsl:element name="fo:block">
            <xsl:attribute name="font-family"><xsl:value-of select="$font.family.sans"/></xsl:attribute>
            <xsl:attribute name="font-size"><xsl:value-of select="$font.caption.size"/></xsl:attribute>
            <xsl:attribute name="line-height"><xsl:value-of select="$font.caption.height"/></xsl:attribute>
            <xsl:attribute name="text-align">justify</xsl:attribute>
            <xsl:attribute name="start-indent">0cm</xsl:attribute>
            <xsl:if test="@figure">
               <fo:inline font-weight="bold">
                  <xsl:text>Figure </xsl:text><xsl:number level="any" count="caption[@figure]" format="1"/>
                  <xsl:text> </xsl:text>
               </fo:inline>
            </xsl:if>
            <xsl:apply-templates/>
         </xsl:element>
      </xsl:element>
   </xsl:template>

   <xsl:template match="caption" mode="side">
      <xsl:variable name="image-width"><xsl:value-of select="format-number(number(parent::img/attribute::width) * (2.54 div $resolution),'0.000')"/></xsl:variable>
      <xsl:element name="fo:block-container">
         <xsl:attribute name="width"><xsl:value-of select="$image-width"/>cm</xsl:attribute>
         <xsl:element name="fo:block">
            <xsl:attribute name="font-family"><xsl:value-of select="$font.family.sans"/></xsl:attribute>
            <xsl:attribute name="font-size"><xsl:value-of select="$font.caption.size"/></xsl:attribute>
            <xsl:attribute name="line-height"><xsl:value-of select="$font.caption.height"/></xsl:attribute>
            <xsl:attribute name="text-align">justify</xsl:attribute>
            <fo:inline font-weight="bold">
               <xsl:if test="@figure">
                  <xsl:text>Figure </xsl:text><xsl:number level="any" count="caption[@figure]" format="1"/>
                  <xsl:text> </xsl:text>
               </xsl:if>
            </fo:inline>
            <xsl:apply-templates/>
         </xsl:element>
      </xsl:element>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- revision history -->
   <!-- =============================================================== -->

   <!--
       Message http://xep.xattic.com/lists/xep-support/1444.html
       suggests to embed the table in another table. This is just
       downright cock-eyed, and doesn't work for tables with 
       absolute widths. It remains the only choice here.
                                                                        -->

   <xsl:template match="revhistory">
      <fo:table padding-before="0.5cm" padding-after="0.5cm" table-layout="fixed">
         <fo:table-column column-width="proportional-column-width(1)"/>
         <fo:table-column column-width="proportional-column-width(4)" />
         <fo:table-column column-width="proportional-column-width(1)"/>
         <fo:table-body>
            <fo:table-row>
               <fo:table-cell>
                  <fo:block><xsl:text> </xsl:text></fo:block>
               </fo:table-cell>
               <fo:table-cell>
                  <fo:table table-layout="fixed">
                     <fo:table-column column-number="1" column-width="proportional-column-width(1)" text-align="left"/>
                     <fo:table-column column-number="2" column-width="proportional-column-width(5)" text-align="left"/>
                     <fo:table-header>
                        <fo:table-row height="{number(substring-before($font.table.height,'pt')) + 4}pt"
                                      color="black">
                           <fo:table-cell number-columns-spanned="2"
                                          text-align="center"
                                          display-align="center"
                                          border-width="0px"
                                          border-top-width="0.5pt"
                                          border-bottom-width="0.5pt"
                                          border-style="solid"
                                          border-color="black">
                              <fo:block font-family="{$font.family.serif}"
                                        font-size="{$font.table.size}"
                                        line-height="{$font.table.height}"
                                        font-weight="bold">Revision History</fo:block>
                           </fo:table-cell>
                        </fo:table-row>
                     </fo:table-header>
                     <fo:table-body>
                        <fo:table-row height="{number(substring-before($font.table.height,'pt')) + 4}pt">
                           <fo:table-cell text-align="left"
                                          display-align="center"
                                          border-width="0px"
                                          border-bottom-width="0.5pt"
                                          border-style="solid"
                                          border-color="black">
                              <fo:block font-family="{$font.family.serif}"
                                        font-size="{$font.table.size}"
                                        line-height="{$font.table.height}">Revision</fo:block>
                           </fo:table-cell>
                           <fo:table-cell text-align="left"
                                          display-align="center"
                                          border-width="0px"
                                          border-bottom-width="0.5pt"
                                          border-style="solid"
                                          border-color="black">
                              <fo:block font-family="{$font.family.serif}"
                                        font-size="{$font.table.size}"
                                        line-height="{$font.table.height}">Date</fo:block>
                           </fo:table-cell>
                        </fo:table-row>
                        <xsl:apply-templates select="revision"/>
                     </fo:table-body>
                  </fo:table>
               </fo:table-cell>
               <fo:table-cell>
                  <fo:block><xsl:text> </xsl:text></fo:block>
               </fo:table-cell>
            </fo:table-row>
         </fo:table-body>
      </fo:table> 
   </xsl:template>

   <xsl:template match="revision">
      <fo:table-row height="{number(substring-before($font.table.height,'pt')) + 4}pt"> 
         <fo:table-cell text-align="left"
                        display-align="center">
            <fo:block font-family="{$font.family.serif}"
                      font-size="{$font.table.size}"
                      line-height="{$font.table.height}">
               <xsl:apply-templates select="revnumber"/>
            </fo:block>
         </fo:table-cell>
         <fo:table-cell text-align="left"
                        display-align="center">
            <fo:block font-family="{$font.family.serif}"
                      font-size="{$font.table.size}"
                      line-height="{$font.table.height}">
               <xsl:apply-templates select="revdate"/>
            </fo:block>
         </fo:table-cell>
      </fo:table-row>
      <fo:table-row height="{number(substring-before($font.table.height,'pt')) + 4}pt">
         <fo:table-cell text-align="left"
                        display-align="center"
                        border-width="0px"
                        border-bottom-width="0.5pt"
                        border-style="solid"
                        border-color="black">
            <fo:block font-family="{$font.family.serif}"
                      font-size="{$font.table.size}"
                      line-height="{$font.table.height}">
               <xsl:text> </xsl:text>
            </fo:block>
         </fo:table-cell>
         <fo:table-cell text-align="left"
                        display-align="center"
                        border-width="0px"
                        border-bottom-width="0.5pt"
                        border-style="solid"
                        border-color="black">
            <fo:block font-family="{$font.family.serif}"
                      font-size="{$font.table.size}"
                      line-height="{$font.table.height}">
               <xsl:apply-templates select="revremark"/>
            </fo:block>
         </fo:table-cell>
      </fo:table-row>
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
   <!-- simple table handling with optional label and optional numbering -->
   <!-- fop processor does not now support fo:table-and-caption, fo:float -->
   <!-- =============================================================== -->

   <xsl:template match="table">
      <xsl:choose>
         <xsl:when test="@align='center'">
            <xsl:variable name="table_width"><xsl:apply-templates select="descendant::tgroup/columns" mode="sum"/></xsl:variable>
            <xsl:variable name="actual_width"><xsl:value-of select="format-number(number($table_width) * (2.54 div $resolution),'0.000')"/></xsl:variable>
            <xsl:choose>
               <xsl:when test="$fo-processor='xep'">
                  <xsl:element name="fo:block-container">
                     <xsl:attribute name="width"><xsl:value-of select="$actual_width"/>cm</xsl:attribute>
                     <xsl:attribute name="start-indent"><xsl:value-of select="format-number((number($body.width) - number($actual_width)) div 2,'0.000')"/>cm</xsl:attribute>
                     <xsl:attribute name="margin">3pt 10pt</xsl:attribute>  <!-- padding -->
                     <xsl:choose>
                        <xsl:when test="//table/label">
                           <xsl:element name="fo:table-and-caption">
                              <xsl:attribute name="keep-together">always</xsl:attribute>
                              <xsl:attribute name="start-indent">0cm</xsl:attribute>
                              <xsl:call-template name="table-caption"/>
                              <xsl:call-template name="table-no-caption"/>
                           </xsl:element>
                        </xsl:when>
                        <xsl:when test="not(//table/label)">
                           <xsl:call-template name="table-no-caption"/>
                        </xsl:when>
                     </xsl:choose>
                  </xsl:element>
               </xsl:when>
               <xsl:when test="$fo-processor='fop'">
                  <fo:table padding-before="0.5cm" padding-after="0.5cm" table-layout="fixed">
                     <fo:table-column column-width="proportional-column-width(1)"/>
                     <fo:table-column column-width="proportional-column-width(4)" />
                     <fo:table-column column-width="proportional-column-width(1)"/>
                     <fo:table-body>
                        <fo:table-row>
                           <fo:table-cell>
                              <fo:block><xsl:text> </xsl:text></fo:block>
                           </fo:table-cell>
                           <fo:table-cell>
                              <xsl:choose>
                                 <xsl:when test="//table/label">
                                    <xsl:apply-templates select="label"/>
                                    <xsl:call-template name="table-no-caption"/>
                                 </xsl:when>
                                 <xsl:when test="not(//table/label)">
                                    <xsl:call-template name="table-no-caption"/>
                                 </xsl:when>
                              </xsl:choose>
                           </fo:table-cell>
                           <fo:table-cell>
                              <fo:block><xsl:text> </xsl:text></fo:block>
                           </fo:table-cell>
                        </fo:table-row>
                     </fo:table-body>
                  </fo:table>
               </xsl:when>
            </xsl:choose>
         </xsl:when>
         <xsl:when test="@align=false()">
            <xsl:element name="fo:block-container">
               <xsl:attribute name="margin">6pt 0pt</xsl:attribute>   <!-- padding -->
               <xsl:choose>
                  <xsl:when test="$fo-processor='xep'">
                     <xsl:choose>
                        <xsl:when test="//table/label">
                           <xsl:element name="fo:table-and-caption">
                              <xsl:attribute name="keep-together">always</xsl:attribute>
                              <xsl:call-template name="table-caption"/>
                              <xsl:call-template name="table-no-caption"/>
                           </xsl:element>
                        </xsl:when>
                        <xsl:when test="not(//table/label)">
                           <xsl:call-template name="table-no-caption"/>
                        </xsl:when>
                     </xsl:choose>
                  </xsl:when>
                  <xsl:when test="$fo-processor='fop'">
                     <xsl:choose>
                        <xsl:when test="//table/label">
                           <xsl:apply-templates select="label"/>
                           <xsl:call-template name="table-no-caption"/>
                        </xsl:when>
                        <xsl:when test="not(//table/label)">
                           <xsl:call-template name="table-no-caption"/>
                        </xsl:when>
                     </xsl:choose>
                  </xsl:when>
               </xsl:choose>
            </xsl:element>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="$fo-processor='xep'">
                  <xsl:element name="fo:float">
                     <xsl:attribute name="float"><xsl:value-of select="@align"/></xsl:attribute>
                     <xsl:attribute name="clear"><xsl:value-of select="@align"/></xsl:attribute>
                     <xsl:element name="fo:block-container">
                        <xsl:attribute name="margin">3pt 10pt</xsl:attribute>   <!-- padding -->
                        <xsl:choose>
                           <xsl:when test="//table/label">
                              <xsl:element name="fo:table-and-caption">
                                 <xsl:attribute name="keep-together">always</xsl:attribute>
                                 <xsl:call-template name="table-caption"/>
                                 <xsl:call-template name="table-no-caption"/>
                              </xsl:element>
                           </xsl:when>
                           <xsl:when test="not(//table/label)">
                              <xsl:call-template name="table-no-caption"/>
                           </xsl:when>
                        </xsl:choose>
                     </xsl:element>
                  </xsl:element>
               </xsl:when>
               <xsl:when test="$fo-processor='fop'">
                  <xsl:element name="fo:block-container">
                     <xsl:attribute name="margin">6pt 0pt</xsl:attribute>   <!-- padding -->
                     <xsl:choose>
                        <xsl:when test="//table/label">
                           <xsl:apply-templates select="label"/>
                           <xsl:call-template name="table-no-caption"/>
                        </xsl:when>
                        <xsl:when test="not(//table/label)">
                           <xsl:call-template name="table-no-caption"/>
                        </xsl:when>
                     </xsl:choose>
                  </xsl:element>
               </xsl:when>
            </xsl:choose>
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

   <xsl:template match="label">
      <xsl:element name="fo:block-container">
         <xsl:variable name="table_width"><xsl:apply-templates select="following-sibling::tgroup/columns" mode="sum"/></xsl:variable>
         <xsl:variable name="actual_width"><xsl:value-of select="format-number(number($table_width) * (2.54 div $resolution),'0.000')"/></xsl:variable>
         <xsl:attribute name="width"><xsl:value-of select="$actual_width"/>cm</xsl:attribute>    
         <xsl:element name="fo:block">
            <xsl:attribute name="font-family"><xsl:value-of select="$font.family.sans"/></xsl:attribute>
            <xsl:attribute name="font-size"><xsl:value-of select="$font.caption.size"/></xsl:attribute>
            <xsl:attribute name="line-height"><xsl:value-of select="$font.caption.height"/></xsl:attribute>
            <xsl:attribute name="text-align">justify</xsl:attribute>
            <xsl:if test="@number='yes'">
               <fo:inline font-weight="bold">
                  Table <xsl:number level="any" count="//table/label[@number]" format="1"/>
                  <xsl:text> </xsl:text>
               </fo:inline>
            </xsl:if>
            <xsl:apply-templates/>
         </xsl:element>
      </xsl:element>
   </xsl:template>

   <xsl:template name="table-caption">
      <fo:table-caption caption-side="before" start-indent="0cm"
                        margin="0pt 0pt 3pt 0pt">
         <xsl:apply-templates select="label"/>
      </fo:table-caption>
   </xsl:template>
   
   <xsl:template name="table-no-caption">
      <fo:table table-layout="fixed">
         <xsl:apply-templates select="tgroup"/>
      </fo:table>
   </xsl:template>

   <xsl:template match="tgroup">
      <xsl:if test="child::columns">
         <xsl:apply-templates select="columns"/>
      </xsl:if>
      <xsl:apply-templates select="thead"/>
      <xsl:choose>
         <xsl:when test="child::node()/row/column/footnote">
            <fo:table-footer>
               <xsl:choose>
                  <xsl:when test="child::tfoot">
                     <xsl:call-template name="tfooter"/>
                     <xsl:apply-templates select="tfoot"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:call-template name="tfooter"/>
                  </xsl:otherwise>
               </xsl:choose>
            </fo:table-footer>
         </xsl:when>
         <xsl:when test="(child::tfoot) and not(child::node()/row/column/footnote)">
            <fo:table-footer>
               <xsl:apply-templates select="tfoot"/>
            </fo:table-footer>
         </xsl:when>
      </xsl:choose>
      <xsl:apply-templates select="tbody"/>
   </xsl:template>

   <xsl:template match="columns">
      <xsl:element name="fo:table-column">
         <xsl:attribute name="column-width"><xsl:value-of select="format-number(@width * (2.54 div $resolution),'0.000')"/>cm</xsl:attribute>
         <xsl:if test="@number=true()">
            <xsl:attribute name="column-number">
               <xsl:value-of select="@number"/>
            </xsl:attribute>
         </xsl:if>
         <xsl:if test="@align=true()">
            <xsl:attribute name="text-align">
               <xsl:value-of select="@align"/>
            </xsl:attribute>
         </xsl:if>
         <xsl:if test="@repeated=true()">
            <xsl:attribute name="number-columns-repeated">
               <xsl:value-of select="@repeated"/>
            </xsl:attribute>
         </xsl:if>
      </xsl:element>
   </xsl:template>
   
   <xsl:template match="thead">
      <fo:table-header>
         <xsl:apply-templates select="row" mode="thead"/>
      </fo:table-header>
   </xsl:template>

   <xsl:template name="tfooter">
      <fo:table-row>
         <fo:table-cell number-columns-spanned="{@cols}">
            <xsl:apply-templates select="child::node()/row/column/footnote" mode="footnote"/>
         </fo:table-cell>
      </fo:table-row>
   </xsl:template>
   
   <xsl:template match="tfoot">
      <xsl:apply-templates select="row" mode="tfoot"/>
   </xsl:template>

   <xsl:template match="tbody">
      <fo:table-body>
         <xsl:apply-templates select="row"/>
      </fo:table-body>
   </xsl:template>

   <xsl:template match="row" mode="thead">
      <xsl:element name="fo:table-row">
         <xsl:attribute name="background-color">white<!-- <xsl:value-of select="$color.counterpoint"/> --></xsl:attribute>
         <xsl:attribute name="height"><xsl:value-of select="number(substring-before($font.table.height,'pt')) + 4"/>pt</xsl:attribute>
         <xsl:attribute name="color">black<!-- white --></xsl:attribute>
         <xsl:attribute name="font-weight">bold</xsl:attribute>
         <xsl:if test="position()=1">
            <xsl:attribute name="border-top-width">0.5pt</xsl:attribute>
            <xsl:attribute name="border-top-style">solid</xsl:attribute>
            <xsl:attribute name="border-top-color">black</xsl:attribute>
         </xsl:if>
         <xsl:if test="position()=last()">
            <xsl:attribute name="border-bottom-width">0.5pt</xsl:attribute>
            <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
            <xsl:attribute name="border-bottom-color">black</xsl:attribute>
         </xsl:if>
         <xsl:apply-templates select="column"/>
      </xsl:element>
   </xsl:template>

   <xsl:template match="row" mode="tfoot">
      <fo:table-row background-color="white"
                    height="{number(substring-before($font.table.height,'pt')) + 4}pt">
         <xsl:apply-templates select="column"/>
      </fo:table-row>
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
      <xsl:element name="fo:table-row">
         <xsl:attribute name="background-color">white<!-- <xsl:value-of select="$color.theme"/> --></xsl:attribute>
         <xsl:attribute name="height"><xsl:value-of select="number(substring-before($font.table.height,'pt')) + 4"/>pt</xsl:attribute>
         <xsl:if test="parent::thead">
            <xsl:attribute name="font-weight">bold</xsl:attribute>
         </xsl:if>
         <xsl:if test="position()=1">
            <xsl:attribute name="border-top-width">0.5pt</xsl:attribute>
            <xsl:attribute name="border-top-style">solid</xsl:attribute>
            <xsl:attribute name="border-top-color">black</xsl:attribute>
         </xsl:if>
         <xsl:if test="position()=last()">
            <xsl:attribute name="border-bottom-width">0.5pt</xsl:attribute>
            <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
            <xsl:attribute name="border-bottom-color">black</xsl:attribute>
         </xsl:if>
         <xsl:apply-templates select="column"/>
      </xsl:element>
   </xsl:template>
   
   <xsl:template name="even-row">
      <xsl:element name="fo:table-row">
         <xsl:attribute name="background-color">white<!-- <xsl:value-of select="$color.light-theme"/> --></xsl:attribute>
         <xsl:attribute name="height"><xsl:value-of select="number(substring-before($font.table.height,'pt')) + 4"/>pt</xsl:attribute>
         <xsl:if test="parent::thead">
            <xsl:attribute name="font-weight">bold</xsl:attribute>
         </xsl:if>
         <xsl:if test="position()=1">
            <xsl:attribute name="border-top-width">0.5pt</xsl:attribute>
            <xsl:attribute name="border-top-style">solid</xsl:attribute>
            <xsl:attribute name="border-top-color">black</xsl:attribute>
         </xsl:if>
         <xsl:if test="position()=last()">
            <xsl:attribute name="border-bottom-width">0.5pt</xsl:attribute>
            <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
            <xsl:attribute name="border-bottom-color">black</xsl:attribute>
         </xsl:if>
         <xsl:apply-templates select="column"/>
      </xsl:element>
   </xsl:template>

   <xsl:template match="column">
      <xsl:element name="fo:table-cell">
         <xsl:choose>
            <xsl:when test="parent::row[@valign='top']">
               <xsl:attribute name="display-align">before</xsl:attribute>
            </xsl:when>
            <xsl:when test="parent::row[@valign='bottom']">
               <xsl:attribute name="display-align">after</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="display-align">center</xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:choose>
            <xsl:when test="@align=true()">
               <xsl:attribute name="text-align"><xsl:value-of select="@align"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="text-align">from-table-column(text-align)</xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:if test="@span=true()">
            <xsl:attribute name="number-columns-spanned"><xsl:value-of select="@span"/></xsl:attribute>
         </xsl:if>
         <xsl:element name="fo:block">
            <xsl:attribute name="font-family"><xsl:value-of select="$font.family.sans"/></xsl:attribute>
            <xsl:attribute name="line-height"><xsl:value-of select="$font.table.height"/></xsl:attribute>
            <xsl:choose>
               <xsl:when test="ancestor::tfoot">
                  <xsl:attribute name="font-size"><xsl:value-of select="$font.footnote.size"/></xsl:attribute>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="font-size"><xsl:value-of select="$font.table.size"/></xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates/>
         </xsl:element>
      </xsl:element>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- insert stop character -->
   <!-- =============================================================== -->

   <xsl:template match="stop">
      <fo:external-graphic src="url({$path-name}{$image-folder}svg/full-stop.svg)"/>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- handling of SmartQuotes -->
   <!-- =============================================================== -->

   <xsl:template match="q" mode="meta-info">&#x0022;<xsl:apply-templates/>&#x0022;</xsl:template>

   <xsl:template match="q">&#x201C;<xsl:apply-templates/>&#x201D;</xsl:template>

   <xsl:template match="sq" mode="meta-info">'<xsl:apply-templates/>'</xsl:template>

   <xsl:template match="sq">&#x2018;<xsl:apply-templates/>&#x2019;</xsl:template>

   <xsl:template match="apos" mode="meta-info">'</xsl:template>

   <xsl:template match="apos">&#x2019;</xsl:template>

</xsl:stylesheet>
