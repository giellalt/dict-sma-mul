<?xml version="1.0"?>
<!--+
    | 
    | merges the doubled entries as a result of the source_lang-files inversion process 
    | Usage: java -Xmx2048m net.sf.saxon.Transform -it main THIS_SCRIPT inFile=INPUT_FILE.xml
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:local="nightbar"
		exclude-result-prefixes="xs local">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" name="xml"
              encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>
  
  <!-- Input files -->
  <xsl:param name="inFile" select="'default.xml'"/>
  
  <!-- Output dir, files -->
  <xsl:variable name="outputDir" select="'eMerged'"/>
  
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
	    <xsl:for-each-group select="doc($inFile)/r/e" group-by="./lg/l">
	      <xsl:if test="count(current-group()) = 1">
		<xsl:copy-of select="current-group()"/>
	      </xsl:if>
	      <xsl:if test="not(count(current-group()) = 1)">
		<e>
		  <!-- 		  <xsl:attribute name="counter"> -->
		  <!-- 		    <xsl:value-of select="count(current-group())"/> -->
		  <!-- 		  </xsl:attribute> -->
		  <xsl:copy-of select="current-group()[1]/@*"/>
		  <xsl:copy-of select="current-group()[1]/lg"/>
		  <xsl:if test="./apps">
		    <apps>
		      <xsl:copy-of select="current-group()//app"/>
		    </apps>
		  </xsl:if>

		  <xsl:copy-of select="current-group()//mg"/>

<!-- 		  <semantics> -->
<!-- 		    <xsl:for-each select="distinct-values(current-group()//semantics/sem/@*)"> -->
<!-- 		      <sem> -->
<!-- 			<xsl:attribute name="class"> -->
<!-- 			  <xsl:value-of select="."/> -->
<!-- 			</xsl:attribute> -->
<!-- 		      </sem> -->
<!-- 		    </xsl:for-each> -->
<!-- 		  </semantics> -->
<!-- 		  <sources> -->
<!-- 		    <xsl:for-each select="distinct-values(current-group()//sources/book/@*)"> -->
<!-- 		      <book> -->
<!-- 			<xsl:attribute name="name"> -->
<!-- 			  <xsl:value-of select="."/> -->
<!-- 			</xsl:attribute> -->
<!-- 		      </book> -->
<!-- 		    </xsl:for-each> -->
<!-- 		  </sources> -->
		  <!-- 		  <ctrl_entry> -->
		  <!-- 		    <xsl:copy-of select="current-group()"/> -->
		  <!-- 		  </ctrl_entry> -->
		</e>
	      </xsl:if>
	      </xsl:for-each-group>
	  </r>
	</xsl:variable>
	
	<!-- out -->
	<xsl:result-document href="{$outputDir}/{$file_name}.{$e}" format="{$output_format}">
	  <xsl:copy-of select="$out_tmp"/>
	</xsl:result-document>

      </xsl:when>
      <xsl:otherwise>
	<xsl:text>Cannot locate: </xsl:text><xsl:value-of select="$inFile"/><xsl:text>&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>


