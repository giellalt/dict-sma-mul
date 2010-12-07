<?xml version="1.0"?>
<!--+
    | Usage: java -Xmx2048m net.sf.saxon.Transform -it main THIS_FILE inDir=DIR
    | Script for moving attributes from stem-element to l-element.
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="xs xhtml">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" name="xml"
	      encoding="UTF-8"
	      omit-xml-declaration="no"
	      doctype-system="../scripts/smenob.dtd"
          doctype-public="-//DivvunGiellatekno//DTD Dictionaries//Multilingual"
	      indent="yes"/>
  
  <xsl:param name="inFile" select="'gogo_file'"/>
  <xsl:param name="inDir" select="'xxx_out_xxx'"/>
  <xsl:variable name="outDir" select="'out_1'"/>
  <xsl:variable name="of" select="'xml'"/>
  <xsl:variable name="e" select="$of"/>
  <xsl:variable name="debug" select="'true_gogo'"/>
  <xsl:variable name="nl" select="'&#xa;'"/>
  <xsl:variable name="slang" select="'sma'"/>
  <xsl:variable name="tlang" select="'nob'"/>
  
  <xsl:template match="/" name="main">

    <xsl:for-each select="for $f in collection(concat($inDir,'?recurse=no;select=n_smanob.xml;on-error=warning')) return $f">
      
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
	<xsl:copy-of copy-namespaces="no" select="./r/lics"/>	
	  <xsl:for-each select="./r/e">
	    <xsl:if test=".[not(stem)]">
	      <!-- 	      <no-stem> --> 
	      <xsl:copy-of copy-namespaces="no" select="."/>
	      <!-- 	      </no-stem> -->
	    </xsl:if>
	    
	    <xsl:if test=".[stem]">
	      <e>
		<xsl:copy-of select="./@*"/>
		  <lg>
		<l>	
		<xsl:copy-of select="./lg/l/@*"/> 		
		<xsl:copy-of select="./stem/@*[not(local-name() = 'class')]"/> 	
	    <xsl:if test=".[(stem/@class)]">
	      <xsl:if test="starts-with(./stem/@class, 'bi')">
			<xsl:attribute name="stem">
			  <xsl:value-of select="'2syll'"/>
			</xsl:attribute>
	      </xsl:if>
	      <xsl:if test="starts-with(./stem/@class, 'tri')">
			<xsl:attribute name="stem">
			  <xsl:value-of select="'3syll'"/>
			</xsl:attribute>
	      </xsl:if>
	    </xsl:if>
		<xsl:value-of select="./lg/l"/> 		
		</l>	  
		  </lg>
		 <stem>
		<xsl:copy-of select="./stem/@class"/> 				 
		 </stem> 
		<xsl:copy-of copy-namespaces="no" select="./*[not(local-name() = 'lg')][not(local-name() = 'stem')]"/>
	      </e>
	      <!-- 		</changed> -->
	      <!-- 	      </doch-oahpa> -->
	      
	    </xsl:if>
	  </xsl:for-each>
	<xsl:copy-of copy-namespaces="yes" select="./r/xhtml:script"/>	
	</r>
      </xsl:variable>
      
      <xsl:result-document href="{$outDir}/{$current_file}" format="{$of}">
        <xsl:processing-instruction name="xml-stylesheet">
          <xsl:text>title="Dictionary view" media="screen,tv,projection" href="../../scripts/gt_dictionary.css" type="text/css"</xsl:text>
        </xsl:processing-instruction>
		<xsl:value-of select="$nl"/> 		
        
        <xsl:processing-instruction name="xml-stylesheet">
          <xsl:text>alternate="yes" title="Hierarchical view" media="screen,tv,projection" href="../../scripts/gt_dictionary_alt.css" type="text/css"</xsl:text>
        </xsl:processing-instruction>
 		<xsl:value-of select="$nl"/> 		
       
	    <xsl:copy-of select="$cufi"/>
      </xsl:result-document>
    </xsl:for-each>
    
  </xsl:template>
  
</xsl:stylesheet>
