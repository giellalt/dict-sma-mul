<?xml version="1.0"?>
<!--+
    | Usage: java -Xmx2048m net.sf.saxon.Transform -it main THIS_FILE inputDir=DIR
    | 
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="xs">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" name="xml"
	      encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>
  
  <xsl:param name="inFile" select="'gogo_file'"/>
  <xsl:param name="inDir" select="'../../src'"/>
  <xsl:variable name="outDir" select="'tg_patterns'"/>
  <xsl:variable name="of" select="'xml'"/>
  <xsl:variable name="e" select="$of"/>
  <xsl:variable name="debug" select="'true_gogo'"/>
  <xsl:variable name="nl" select="'&#xa;'"/>
  <xsl:variable name="slang" select="'sma'"/>
  <xsl:variable name="tlang" select="'nob'"/>
  
  <xsl:template match="/" name="main">

    <xsl:for-each select="for $f in collection(concat($inDir,'?recurse=no;select=*.xml;on-error=warning')) return $f">
      
      <xsl:variable name="current_file" select="(tokenize(document-uri(.), '/'))[last()]"/>
      <xsl:variable name="current_dir" select="substring-before(document-uri(.), $current_file)"/>
      <xsl:variable name="current_location" select="concat($inDir, substring-after($current_dir, $inDir))"/>
      
      <xsl:if test="$debug = 'true_gogo'">
	<xsl:message terminate="no">
	  <xsl:value-of select="concat('-----------------------------------------', $nl)"/>
	  <xsl:value-of select="concat('processing file ', $current_file, $nl)"/>
	  <xsl:value-of select="'-----------------------------------------'"/>
	</xsl:message>
      </xsl:if>
      
      <xsl:variable name="cufi">
	<r xml:lang="{$slang}">
	  <xsl:for-each select="./r/e">
	    <e lemma="{normalize-space(./lg/l/text())}" mg_c="{count(./mg)}">
	      <xsl:for-each select="./mg">
		<mg tg_c="{count(./tg)}">
		  <xsl:for-each select="./tg">
		    <tg>
		      <xsl:variable name="p">
			<xsl:for-each select="./*">
			  <xsl:if test="not(position() = last())">
			    <xsl:value-of select="concat(local-name(.), '_')"/>
			  </xsl:if>
			  <xsl:if test="position() = last()">
			    <xsl:value-of select="local-name(.)"/>
			  </xsl:if>
			</xsl:for-each>
		      </xsl:variable>
		      <xsl:attribute name="p">
			<xsl:value-of select="$p"/>
		      </xsl:attribute>
		    </tg>
		  </xsl:for-each>
		</mg>
	      </xsl:for-each>
	    </e>
	  </xsl:for-each>
	</r>
      </xsl:variable>
      
      <xsl:result-document href="{$outDir}/{$current_file}" format="{$of}">
	<xsl:copy-of select="$cufi"/>
      </xsl:result-document>
    </xsl:for-each>
    
  </xsl:template>
  
</xsl:stylesheet>
