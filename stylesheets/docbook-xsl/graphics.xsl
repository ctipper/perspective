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
   <!-- inserting images -->
   <!-- =============================================================== -->

   <!-- =============================================================== -->
   <!-- inline images -->
   <!-- =============================================================== -->

   <xsl:template match="db:inlinemediaobject//db:imagedata">
      <xsl:choose>
         <xsl:when test="string(@role)='glyph'">
            <!-- noop -->
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="img">
               <xsl:attribute name="src">
                  <xsl:value-of select="$path-name"/><xsl:value-of select="$image-folder"/><xsl:value-of select="@fileref"/>
               </xsl:attribute>
               <xsl:if test="@align=true()">
                  <xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
               </xsl:if>
               <xsl:if test="@contentwidth=true()">
                  <xsl:attribute name="width"><xsl:value-of select="@contentwidth"/></xsl:attribute>
               </xsl:if>
               <xsl:if test="@contentdepth=true()">
                  <xsl:attribute name="height"><xsl:value-of select="@contentdepth"/></xsl:attribute>
               </xsl:if>
               <xsl:attribute name="title"><xsl:value-of select="parent::node()/preceding-sibling::db:alt"/></xsl:attribute>
               <xsl:attribute name="alt"><xsl:value-of select="parent::node()/preceding-sibling::db:alt"/></xsl:attribute>
               <xsl:text> </xsl:text>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- block level images -->
   <!-- =============================================================== -->

   <xsl:template match="db:mediaobject">
      <xsl:choose>
         <xsl:when test="child::db:imageobject/child::db:imagedata/attribute::align='center'">
            <xsl:choose>
               <xsl:when test="contains(child::db:imageobject/child::db:imagedata/attribute::contentwidth,'cm')">
                  <xsl:element name="div">
                     <xsl:attribute name="style"><xsl:text>width: </xsl:text>
                     <xsl:value-of select="format-number(number(substring-before(child::db:imageobject/child::db:imagedata/attribute::width,'cm'))
                                           * ($resolution div 2.54),'0')" />
                     <xsl:text>px; background: white; margin-left: auto; margin-right: auto;</xsl:text>
                     </xsl:attribute>
                     <xsl:apply-templates/>
                  </xsl:element>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:element name="div">
                     <xsl:attribute name="style"><xsl:text>width: </xsl:text>
                     <xsl:value-of select="child::db:imageobject/child::db:imagedata/attribute::width" />
                     <xsl:text>px; background: white; margin-left: auto; margin-right: auto;</xsl:text>
                     </xsl:attribute>
                     <xsl:apply-templates/>
                  </xsl:element>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
            <!-- optional size 'cm' -->
            <div style="float: {child::db:imageobject/child::db:imagedata/attribute::align}; background-color: white;">
               <xsl:apply-templates/>
            </div>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="db:imageobject">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="db:alt">
      <!-- swallow title element as this is mapped to 'title' attribute of img tag in HTML -->
   </xsl:template>

   <!-- =============================================================== -->
   <!-- following optionally accepts image sizes in 'cm' -->
   <!-- =============================================================== -->

   <xsl:template match="db:imagedata">
      <xsl:choose>
         <!-- Becomes 'svg' when possible to serve image/svg+xml -->
         <xsl:when test="@role='svg'">
            <xsl:element name="object">
               <xsl:attribute name="data"><xsl:value-of select="$path-name" /><xsl:value-of select="$image-folder"/>svg/<xsl:value-of select="substring-before(@fileref,'.')"/>.svg</xsl:attribute>
               <xsl:attribute name="type">image/svg+xml</xsl:attribute>
               <xsl:call-template name="insert-image" />
            </xsl:element>
         </xsl:when>
         <xsl:otherwise>
            <xsl:call-template name="insert-image" />
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- insert img -->
   <!-- =============================================================== -->

   <xsl:template name="insert-image">
      <xsl:element name="img">
         <xsl:attribute name="src">
            <xsl:value-of select="$path-name"/>
            <xsl:value-of select="$image-folder"/>
            <xsl:value-of select="@fileref"/>
         </xsl:attribute>
         <!-- content width -->
         <xsl:choose>
            <xsl:when test="contains(@contentwidth,'cm')">
               <xsl:attribute name="width">
                  <xsl:value-of select="format-number(number(substring-before(@contentwidth,'cm')) * ($resolution div 2.54),'0')"/>
               </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="width"><xsl:value-of select="@contentwidth"/></xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>
         <!-- content depth -->
         <xsl:choose>
            <xsl:when test="contains(@contentdepth,'cm')">
               <xsl:attribute name="height">
                  <xsl:value-of select="format-number(number(substring-before(@contentdepth,'cm')) * ($resolution div 2.54),'0')"/>
               </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="height"><xsl:value-of select="@contentdepth"/></xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:attribute name="title"><xsl:value-of select="parent::node()/preceding-sibling::db:alt"/></xsl:attribute>
         <xsl:attribute name="alt"><xsl:value-of select="parent::node()/preceding-sibling::db:alt"/></xsl:attribute>
         <xsl:attribute name="style">
            <xsl:text>padding: </xsl:text>
            <xsl:choose>
               <xsl:when test="contains(@contentwidth,'cm')">
                  <xsl:value-of select="format-number(((number(substring-before(attribute::width,'cm')) - 
                                        number(substring-before(attribute::contentwidth,'cm')))
                                        * ($resolution div 2.54) div 2),'0')" />
                  <xsl:text>px </xsl:text>
                  <xsl:value-of select="format-number(((number(substring-before(attribute::width,'cm')) - 
                                        number(substring-before(attribute::contentwidth,'cm')))
                                        * ($resolution div 2.54) div 2),'0')" />
                  <xsl:text>px 0;</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="format-number(((number(attribute::width) - number(attribute::contentwidth)) div 2),'0')" />
                  <xsl:text>px </xsl:text>
                  <xsl:value-of select="format-number(((number(attribute::width) - number(attribute::contentwidth)) div 2),'0')" />
                  <xsl:text>px 0;</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>
   </xsl:template>

   <!-- =============================================================== -->
   <!-- caption allows for optional figure numbering 
        role attribute set to 'figure' to trigger numbering
        Note code to implement optional 'cm' dimension
     -->
   <!-- =============================================================== -->

   <xsl:template match="db:caption/db:para">
      <xsl:choose>
         <xsl:when test="contains(parent::db:caption/preceding-sibling::db:imageobject/child::db:imagedata/attribute::contentwidth,'cm')">
            <xsl:element name="p">
               <xsl:attribute name="class">caption</xsl:attribute>
               <xsl:attribute name="style">
                  <xsl:text>width: </xsl:text>
                  <xsl:value-of select="format-number(number(substring-before(
                                        parent::db:caption/preceding-sibling::db:imageobject/child::db:imagedata/attribute::contentwidth,'cm')) *
                                        ($resolution div 2.54),'0')" />
                  <xsl:text>px;</xsl:text>
                  <xsl:text> padding: </xsl:text>
                  <xsl:text>0 </xsl:text>
                  <xsl:value-of select="format-number(((number(substring-before(parent::db:caption/preceding-sibling::db:imageobject/child::db:imagedata/attribute::width,'cm')) - 
                                        number(substring-before(parent::db:caption/preceding-sibling::db:imageobject/child::db:imagedata/attribute::contentwidth,'cm')))
                                        * ($resolution div 2.54) div 2),'0')" />
                  <xsl:text>px </xsl:text>
                  <xsl:value-of select="format-number(((number(substring-before(parent::db:caption/preceding-sibling::db:imageobject/child::db:imagedata/attribute::width,'cm')) - 
                                        number(substring-before(parent::db:caption/preceding-sibling::db:imageobject/child::db:imagedata/attribute::contentwidth,'cm')))
                                        * ($resolution div 2.54) div 2),'0')" />
                  <xsl:text>px;</xsl:text>
               </xsl:attribute>
               <xsl:if test="parent::db:caption/attribute::role['figure']">
                  <strong>Figure <xsl:number level="any" count="//db:caption[@role]" format="1"/></strong>
                  <xsl:text> </xsl:text>
               </xsl:if>
               <xsl:apply-templates/>
            </xsl:element>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="p">
               <xsl:attribute name="class">caption</xsl:attribute>
               <xsl:attribute name="style">
                  <xsl:text>width: </xsl:text>
                  <xsl:value-of select="parent::db:caption/preceding-sibling::db:imageobject/child::db:imagedata/attribute::contentwidth" />
                  <xsl:text>px;</xsl:text>
                  <xsl:text> padding: </xsl:text>
                  <xsl:text>0 </xsl:text>
                  <xsl:value-of select="format-number(((number(parent::db:caption/preceding-sibling::db:imageobject/child::db:imagedata/attribute::width) - 
                                        number(parent::db:caption/preceding-sibling::db:imageobject/child::db:imagedata/attribute::contentwidth)) div 2),'0')" />
                  <xsl:text>px </xsl:text>
                  <xsl:value-of select="format-number(((number(parent::db:caption/preceding-sibling::db:imageobject/child::db:imagedata/attribute::width) - 
                                        number(parent::db:caption/preceding-sibling::db:imageobject/child::db:imagedata/attribute::contentwidth)) div 2),'0')" />
                  <xsl:text>px;</xsl:text>
               </xsl:attribute>
               <xsl:if test="parent::db:caption/attribute::role['figure']">
                  <strong>Figure <xsl:number level="any" count="//db:caption[@role]" format="1"/></strong>
                  <xsl:text> </xsl:text>
               </xsl:if>
               <xsl:apply-templates/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
