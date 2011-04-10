<?xml version="1.0"?>
<!--+
    | Usage: java -Xmx2048m net.sf.saxon.Transform -it main THIS_FILE inputDir=DIR
    | 
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="xs xhtml">

  <xsl:strip-space elements="*"/>
  <!--   <xsl:preserve-space elements="lics lic sourcenote"/> -->
  <xsl:output method="xml" name="xml"
	      encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>
  
  <xsl:param name="inDir" select="'xxx_out_xxx'"/>
  <xsl:variable name="outDir" select="'yyy_out_yyy'"/>
  <xsl:variable name="of" select="'xml'"/>
  <xsl:variable name="e" select="$of"/>
  <xsl:variable name="debug" select="true()"/>
  <xsl:variable name="nl" select="'&#xa;'"/>

  <xsl:template match="/" name="main">
    <xsl:for-each select="for $f in collection(concat($inDir,'?recurse=no;select=*.xml;on-error=warning')) return $f">
      
      <xsl:variable name="current_file" select="(tokenize(document-uri(.), '/'))[last()]"/>
      <xsl:variable name="current_dir" select="substring-before(document-uri(.), $current_file)"/>
      <xsl:variable name="current_location" select="concat($inDir, substring-after($current_dir, $inDir))"/>
      
      <xsl:if test="$debug">
	<xsl:message terminate="no">
	  <xsl:value-of select="concat('-----------------------------------------', $nl)"/>
	  <xsl:value-of select="concat('processing file ', $current_file, $nl)"/>
	  <xsl:value-of select="'-----------------------------------------'"/>
	</xsl:message>
      </xsl:if>
      
      <xsl:variable name="c_file">
	<r>
	  <xsl:copy-of select="./r/@*"/>
	  <xsl:for-each select="./r/e">

	    <xsl:if test="$debug">
	      <xsl:message terminate="no">
		<xsl:value-of select="concat('....................processing lemma ', ./lg/l, $nl)"/>
	      </xsl:message>
	    </xsl:if>

	    <e>
	      <xsl:copy-of select="./@*"/>
	      <xsl:copy-of select="./*[not(local-name() = 'mg')]"/>
	      <xsl:for-each select="./mg">
		<xsl:if test="not(./@xml:lang)">
		  <mg>
		    <xsl:for-each select="./tg">
		      
		      <!-- just pre-tests -->
		      <!-- 		      <xsl:if test="./@xml:lang = 'nob'"> -->
		      <!-- 			<xsl:if test="following-sibling::tg[1][./@xml:lang = 'swe']"> -->
		      <!-- 			  <yes_brother_swe> -->
		      <!-- 			    <xsl:copy-of select="." copy-namespaces="no"/> -->
		      <!-- 			  </yes_brother_swe> -->
		      <!-- 			</xsl:if> -->
		      
		      <!-- 			<xsl:if test="not(following-sibling::tg[1][./@xml:lang = 'swe'])"> -->
		      <!-- 			  <no_brother_swe> -->
		      <!-- 			    <xsl:copy-of select="." copy-namespaces="no"/> -->
		      <!-- 			  </no_brother_swe> -->
		      <!-- 			</xsl:if> -->
		      <!-- 		      </xsl:if> -->
		      
		      
		      <!-- 		      <xsl:if test="./@xml:lang = 'swe'"> -->
		      <!-- 			<xsl:if test="preceding-sibling::tg[1][./@xml:lang = 'nob']"> -->
		      <!-- 			  <xsl:if test="not(following-sibling::tg[1][./@xml:lang = 'swe'])"> -->
		      <!-- 			    <yes_brother_nob> -->
		      <!-- 			      <xsl:copy-of select="." copy-namespaces="no"/> -->
		      <!-- 			    </yes_brother_nob> -->
		      <!-- 			  </xsl:if> -->
		      <!-- 			  <xsl:if test="following-sibling::tg[1][./@xml:lang = 'swe']"> -->
		      <!-- 			    <tg xml:lang="swe" check="'semantics_and_re'"> -->
		      <!-- 			      <xsl:copy-of select="preceding-sibling::tg[1][./@xml:lang = 'nob']/semantics" copy-namespaces="no"/> -->
		      <!-- 			      <xsl:if test="preceding-sibling::tg[1][./@xml:lang = 'nob']/re"> -->
		      <!-- 				<re> -->
		      <!-- 				  <xsl:value-of select="concat(preceding-sibling::tg[1][./@xml:lang = 'nob']/re, '_SWE')"/> -->
		      <!-- 				</re> -->
		      <!-- 			      </xsl:if> -->
		      <!-- 			      <xsl:copy-of select="./*" copy-namespaces="no"/> -->
		      <!-- 			    </tg> -->
		      <!-- 			  </xsl:if> -->
		      <!-- 			</xsl:if> -->
		      
		      <xsl:if test="./@xml:lang = 'nob'">
			<xsl:copy-of select="." copy-namespaces="no"/>
			<xsl:if test="not(following-sibling::tg[1][./@xml:lang = 'swe'])">
			  <tg xml:lang="swe">
			    <xsl:copy-of select="./semantics" copy-namespaces="no"/>
			    <xsl:if test="./re">
			      <re>
				<xsl:value-of select="concat(normalize-space(./re), '_SWE')"/>
			      </re>
			    </xsl:if>
			    
			    <xsl:if test=".//.[@stat][@stat='pref']">
			      <xsl:variable name="lname" select="./*[@stat = 'pref']/local-name()"/>
			      <xsl:element name="{$lname}">
				<xsl:copy-of select="./*[@stat = 'pref']/@*[not(. = 'nob')]"/>
				<xsl:attribute name="xml:lang">
				  <xsl:value-of select="'swe'"/>
				</xsl:attribute>
				<xsl:value-of select="concat(normalize-space(./*[@stat = 'pref']), '_SWE')"/>
			      </xsl:element>
			    </xsl:if>
			    
			    <xsl:if test="not(.//.[@stat][@stat='pref'])">
			      <xsl:variable name="lname" select="./*[starts-with(local-name(), 't')][1]/local-name()"/>
			      <xsl:element name="{$lname}">
				<xsl:copy-of select="./*[starts-with(local-name(), 't')][1]/@*[not(. = 'nob')]"/>
				<xsl:attribute name="xml:lang">
				  <xsl:value-of select="'swe'"/>
				</xsl:attribute>
				<xsl:value-of select="concat(normalize-space(./*[starts-with(local-name(), 't')][1]), '_SWE')"/>
			      </xsl:element>
			    </xsl:if>
			  </tg>
			</xsl:if>
		      </xsl:if>
		      
		      <xsl:if test="./@xml:lang = 'swe'">
			<xsl:if test="preceding-sibling::tg[1][./@xml:lang = 'nob']">
			  <tg xml:lang="swe" check="'semantics_and_re'">
			    <xsl:copy-of select="preceding-sibling::tg[1][./@xml:lang = 'nob']/semantics" copy-namespaces="no"/>
			    <xsl:if test="preceding-sibling::tg[1][./@xml:lang = 'nob']/re">
			      <re>
				<xsl:value-of select="concat(normalize-space(preceding-sibling::tg[1][./@xml:lang = 'nob']/re), '_SWE')"/>
			      </re>
			    </xsl:if>
			    <xsl:copy-of select="./*" copy-namespaces="no"/>
			  </tg>
			</xsl:if>
			
			<xsl:if test="not(preceding-sibling::tg[1][./@xml:lang = 'nob'])">
			  <tg xml:lang="swe" check="'semantics_and_re'">
			    <xsl:copy-of select="./*" copy-namespaces="no"/>
			  </tg>
			</xsl:if>
			
		      </xsl:if>
		    </xsl:for-each>
		  </mg>
		</xsl:if>
		
		<xsl:if test="./@xml:lang = 'sme'">
		  <xsl:copy-of select="." copy-namespaces="no"/>
		</xsl:if>
	      </xsl:for-each>
	    </e>
	  </xsl:for-each>
	</r>
      </xsl:variable>
      
      <xsl:if test="not(count($c_file//e) = 0)">      
	<xsl:result-document href="{$outDir}/{$current_file}" format="{$of}">
	  <xsl:copy-of select="$c_file"/>
	</xsl:result-document>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>
