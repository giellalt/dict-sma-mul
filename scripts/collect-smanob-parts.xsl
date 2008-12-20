<?xml version="1.0"?>
<!--+
    | 
    | The input: a dummy.xml file
    | The paraeters: the paths to the individual dictionary files
    | Usage: xsltproc  dummy.xml collect-smanob-parts.xsl PARAM_01..PARAM-06
    | 
    +-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml"
	      encoding="UTF-8"
	      omit-xml-declaration="no"
	      doctype-system="../scripts/smanob.dtd"
	      doctype-public="-//XMLmind//DTD smanob//SE"
	      indent="yes"/>
  
<xsl:param name="adj"/>
<!--<xsl:param name="adv"/>-->
<xsl:param name="noun"/>
<!--<xsl:param name="nounp"/>-->
<xsl:param name="other"/>
<xsl:param name="verb"/>


  <xsl:template match="*">

    <xsl:processing-instruction name="xml-stylesheet">
      <xsl:text>type="text/css" href="../scripts/smanob.css"</xsl:text>
    </xsl:processing-instruction>
    
    <xsl:text>
</xsl:text>

    <xsl:processing-instruction name="xml-stylesheet">
      <xsl:text>type="text/xsl" href="../scripts/smanob.xsl"</xsl:text>
    </xsl:processing-instruction>

    <xsl:text>
</xsl:text>

    <r>
      <xsl:copy-of select="document($adj)/r/e"/>
<!--      <xsl:copy-of select="document($adv)/r/e"/>-->
      <xsl:copy-of select="document($noun)/r/e"/>
<!--      <xsl:copy-of select="document($nounp)/r/e"/>-->
      <xsl:copy-of select="document($other)/r/e"/>
      <xsl:copy-of select="document($verb)/r/e"/>
    </r>
  </xsl:template>
  
</xsl:stylesheet>
