<?xml version="1.0"?>
<!--+
    | Generates a text file for in lex format "SOURCE_LEMMA:TARGET_LEMMA # ;"
    | NB: An XSLT-2.0-processor is needed!
    | The input: SOURCE_LANG-TARGET_LANG.xml file(s)
    | Usage: xsltproc  CAT_smanob.xml smanob-pairs.xsl
    | 
    +-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:strip-space elements="*"/>
  <xsl:output method="text"
	      omit-xml-declaration="yes"
	      indent="no"/>
  
  <xsl:template match="r">
    <xsl:text>LEXICON Root</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>
</xsl:text>
  </xsl:template>
  
  <xsl:template match="e">
    <xsl:text>
</xsl:text>
<xsl:value-of select="lg/l"/>:<xsl:value-of select="replace(normalize-space(mg[1]/tg[1]/t[1]),' ', '_')"/>
    <xsl:text> # ;</xsl:text>
  </xsl:template>
  
</xsl:stylesheet>

