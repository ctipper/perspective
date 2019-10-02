<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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

   <!-- stylesheet parameters -->

   <xsl:param name="path-name">../site/</xsl:param>         <!-- default path name -->
   <xsl:param name="file-name">e-template</xsl:param>       <!-- default file name -->
   <xsl:param name="image-folder">images/</xsl:param>       <!-- image directory -->
   <xsl:param name="resolution">152.4</xsl:param>           <!-- _input_ graphics resolution, dpi -->
   <xsl:param name="email-address">email@param.xsl</xsl:param>     <!-- author's email address -->
   <xsl:param name="site-url">http://www.example.com/</xsl:param>  <!-- site address -->
   <xsl:param name="sect-number">off</xsl:param>            <!-- section numbering 'on' or 'off' -->
   <xsl:param name="dropped-caps">no</xsl:param>            <!-- dropped capitals 'yes' or 'no' -->

   <!-- ******************************************************************** 
        A definition of the input graphics resolution
        ********************************************************************
        Width of A4 body defined to be 16cm
        Width of A4 body defined to be 960px
        Input resolution is calculated as follows: (2.54 * 960) / 16 = 152.4 dpi
        In general $resolution = (2.54 * pxs) / 16cm
        ******************************************************************** -->

</xsl:stylesheet> 
