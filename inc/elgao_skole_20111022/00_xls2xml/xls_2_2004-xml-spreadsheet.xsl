<?xml version="1.0"?>
<!--+
    | 
    | change the FileMaker XML files into something human-readable 
    | Usage: java net.sf.saxon.Transform -it main STYLESHEET_NAME.xsl inFile=INPUT_FILE_NAME.xml
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:local="nightbar"
		xmlns:fmp="http://www.filemaker.com/fmpxmlresult"
		xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
		exclude-result-prefixes="xs local fmp ss">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" name="xml"
              encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>
<!--
egyptejhmesopotamije-300911-godkjent.xml 
esiestimmie-300911-godkjent.xml          
europagaskeaejkesne-300911-godkjent.xml  
hellasejhromerrijhke-300911-godkjent.xml
laanth-300911-godkjent.xml
nommh-300911-godkjent.xml
nrjegaskeaejkesne-300911-godkjent.xml
staarh-300911-godkjent.xml
vijkingeaejkie-300911-godkjent.xml
-->

  
  <!-- Input files -->
  <!-- xsl:param name="inFile" select="'egyptejhmesopotamije-300911-godkjent.xml'"/ -->
  <!-- xsl:param name="inFile" select="'esiestimmie-300911-godkjent.xml'"/ -->
  <!-- xsl:param name="inFile" select="'europagaskeaejkesne-300911-godkjent.xml'"/ -->
  <!-- xsl:param name="inFile" select="'hellasejhromerrijhke-300911-godkjent.xml'"/ -->
  <!-- xsl:param name="inFile" select="'laanth-300911-godkjent.xml'"/ -->
  <!-- xsl:param name="inFile" select="'nommh-300911-godkjent.xml'"/ -->
  <!-- xsl:param name="inFile" select="'nrjegaskeaejkesne-300911-godkjent.xml'"/ -->
  <!-- xsl:param name="inFile" select="'staarh-300911-godkjent.xml'"/ -->
  <xsl:param name="inFile" select="'vijkingeaejkie-300911-godkjent.xml'"/>

  <!-- Output files -->
  <xsl:variable name="outputDir" select="'ResultDir'"/>
  
  <!-- Patterns for the feature values -->
  <xsl:variable name="output_format" select="'xml'"/>
  <xsl:variable name="e" select="$output_format"/>
  <xsl:variable name="file_name" select="substring-before((tokenize($inFile, '/'))[last()], '.xml')"/>
  <xsl:variable name="nl" select="'&#xA;'"/>
  <xsl:variable name="debug" select="true()"/>
  
  
  
  <xsl:template match="/" name="main">
    
    <xsl:choose>
      <xsl:when test="doc-available($inFile)">
	
	<xsl:variable name="column_map">
	  <label cell_count="{count(doc($inFile)/*:Workbook/*:Worksheet/*:Table/*:Row[1]//*:Cell)}">
	    <xsl:for-each select="doc($inFile)/*:Workbook/*:Worksheet/*:Table/*:Row[1]//*:Cell">
	      
	      <xsl:message terminate="no">
		<xsl:value-of select="concat('Processing column: ', .)"/>
	      </xsl:message>
	      
	      <xsl:element name="col">
		<xsl:attribute name="id">
		  <xsl:value-of select="position()"/>
		</xsl:attribute>
		<xsl:value-of select="./*:Data//text()"/>
	      </xsl:element>
	    </xsl:for-each>
	  </label>
	</xsl:variable>

	<xsl:variable name="content">
	  <content>
	    <xsl:for-each select="doc($inFile)/*:Workbook/*:Worksheet/*:Table/*:Row[position() &gt; 1]">
	      <row cell_count="{count(.//*:Cell)}">
		
		<xsl:for-each select=".//*:Cell">
		  <xsl:message terminate="no">
		    <xsl:value-of select="concat('Processing column: ', .)"/>
		  </xsl:message>
		  
		  <xsl:element name="col">
		    <xsl:attribute name="id">
		      <xsl:value-of select="position()"/>
		    </xsl:attribute>
		    <xsl:value-of select="./*:Data//text()"/>
		  </xsl:element>
		</xsl:for-each>
	      </row>
	    </xsl:for-each>
	  </content>
	</xsl:variable>
	
	<!-- output document -->
	<xsl:result-document href="{$outputDir}/result_{$file_name}.{$e}" format="{$output_format}">
	  <output>
	    <xsl:copy-of select="$column_map"/>
	    <xsl:copy-of select="$content"/>
	  </output>
	</xsl:result-document>

      </xsl:when>
      <xsl:otherwise>
	<xsl:text>Cannot locate: </xsl:text><xsl:value-of select="$inFile"/><xsl:text>&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>

