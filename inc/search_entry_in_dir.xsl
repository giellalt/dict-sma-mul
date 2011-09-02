<?xml version="1.0"?>
<!--+
    | Usage: java -Xmx2048m net.sf.saxon.Transform -it main THIS_SCRIPT inFile1=INPUT_FILE-1.xml inFile2=INPUT_FILE-2.xml
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:functx="http://www.functx.com"
		exclude-result-prefixes="xs functx">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" name="xml"
              encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>

  <!-- Input files -->
  <xsl:param name="inFile" select="'Newsmalemmat_duodji.cvs.xml'"/>
  <xsl:param name="inDir" select="'../src'"/>
  
  <!-- Output dir, files -->
  <xsl:variable name="outDir" select="'outDDD'"/>
  
  <!-- Patterns for the feature values -->
  <xsl:variable name="output_format" select="'xml'"/>
  <xsl:variable name="e" select="$output_format"/>
  <xsl:variable name="file_name" select="substring-before((tokenize($inFile, '/'))[last()], '.xml')"/>
  
  <xsl:template match="/" name="main">
    <xsl:choose>
      <xsl:when test="doc-available($inFile)">
	<xsl:variable name="out_tmp">
	  <r>
	    <xsl:copy-of select="doc($inFile)/r/@*"/>
	    <xsl:for-each select="doc($inFile)/r/e">

	      <xsl:variable name="cPOS" select="./lg/l/@pos"/>
	      
	      <xsl:if test=".[not(./lg/l = collection(concat($inDir, '?recurse=no;select=*.xml;on-error=warning'))/r/e/lg/l[./@pos = $cPOS])]">
		<e>
		  <xsl:copy-of select="./@*"/>
		  <xsl:copy-of select="./*"/>
		</e>
	      </xsl:if>
	    </xsl:for-each>
	  </r>
	</xsl:variable>
	
	<!-- out -->
	<xsl:result-document href="{$outDir}/{$file_name}.{$e}" format="{$output_format}">
	  <xsl:copy-of select="$out_tmp"/>
	</xsl:result-document>
	
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>Cannot locate: </xsl:text><xsl:value-of select="$inFile"/><xsl:text>&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
