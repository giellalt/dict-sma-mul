<?xml version="1.0"?>
<!--+
    | 
    | compares (ped vs. smenob) and put ped-flags on smenob-entries 
    | Usage: java net.sf.saxon.Transform -it main cfSmeSmj.xsl
    +-->

<!-- java -Xmx2048m net.sf.saxon.Transform -it main cfPED_resources.xsl ped_file=xml/nouns.xml smenob_file=../src/nounCommon_smenob.xml -->
<!-- java -Xmx2048m net.sf.saxon.Transform -it main flagSmenob.xsl ped_file=xml/adjectives.xml smenob_file=../src/adjective_smenob.xml  -->

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
  <xsl:param name="inputFile" select="'default.xml'"/>

  <!-- Output files -->
  <xsl:variable name="outputDir" select="'ResultDir'"/>
  
  <!-- Patterns for the feature values -->
  <xsl:variable name="output_format" select="'xml'"/>
  <xsl:variable name="e" select="$output_format"/>
  <xsl:variable name="file_name" select="substring-before((tokenize($inputFile, '/'))[last()], '.xml')"/>
  

  
  
  <xsl:template match="/" name="main">
    
    <xsl:choose>
      <xsl:when test="doc-available($inputFile)">
	
	<!-- indent document -->
	<!-- 	<xsl:result-document href="{$outputDir}/{$file_name}.{$e}" format="{$output_format}"> -->
	<!-- 	  <xsl:copy-of select="doc($toIndent)"/> -->
	<!-- 	</xsl:result-document> -->
	
	<xsl:variable name="dictionary">
	  <r>
	    <xsl:for-each select="doc($inputFile)//e">
	      <e>
		<lg>
		  <l>
		    <xsl:if test="./info/d">
		      <xsl:choose>
			<xsl:when test="./info/d[1] = '- v.'">
			  <xsl:attribute name="pos">
			    <xsl:value-of select="'v'"/>
			  </xsl:attribute>
			  <xsl:if test="./info/vcat">
			    <xsl:attribute name="gr">
			      <xsl:value-of select="./info/vcat"/>
			    </xsl:attribute>
			  </xsl:if>
			  <xsl:if test="./info/v3p">
			    <xsl:attribute name="p3p">
			      <xsl:value-of select="./info/v3p"/>
			    </xsl:attribute>
			  </xsl:if>
			</xsl:when>
			<xsl:when test="./info/d[1] = '- adj.'">
			  <xsl:attribute name="pos">
			    <xsl:value-of select="'a'"/>
			  </xsl:attribute>
			</xsl:when>
			<xsl:when test="./info/d[1] = '- s.'">
			  <xsl:attribute name="pos">
			    <xsl:value-of select="'n'"/>
			  </xsl:attribute>
			</xsl:when>
			<xsl:when test="./info/d[1] = '- adv.'">
			  <xsl:attribute name="pos">
			    <xsl:value-of select="'adv'"/>
			  </xsl:attribute>
			</xsl:when>
			<xsl:when test="./info/d[1] = '- interj.'">
			  <xsl:attribute name="pos">
			    <xsl:value-of select="'i'"/>
			  </xsl:attribute>
			</xsl:when>
			<xsl:when test="./info/d[1] = '- konj.'">
			  <xsl:attribute name="pos">
			    <xsl:value-of select="'cc'"/>
			  </xsl:attribute>
			</xsl:when>
			<xsl:when test="./info/d[1] = '- num.'">
			  <xsl:attribute name="pos">
			    <xsl:value-of select="'num'"/>
			  </xsl:attribute>
			</xsl:when>
			<xsl:when test="./info/d[1] = '- part.'">
			  <xsl:attribute name="pos">
			    <xsl:value-of select="'pcle'"/>
			  </xsl:attribute>
			</xsl:when>
			<xsl:when test="./info/d[1] = '- postpos.'">
			  <xsl:attribute name="pos">
			    <xsl:value-of select="'po'"/>
			  </xsl:attribute>
			</xsl:when>
			<xsl:when test="./info/d[1] = '- prep.'">
			  <xsl:attribute name="pos">
			    <xsl:value-of select="'pr'"/>
			  </xsl:attribute>
			</xsl:when>
			<xsl:when test="./info/d[1] = '- pron.'">
			  <xsl:attribute name="pos">
			    <xsl:value-of select="'pron'"/>
			  </xsl:attribute>
			</xsl:when>

			<!-- 			<xsl:otherwise> -->
			<!-- 			  <xsl:attribute name="pos"> -->
			<!-- 			    <xsl:value-of select="string-after(./info/d[1], ' ')"/> -->
			<!-- 			  </xsl:attribute> -->
			<!-- 			</xsl:otherwise> -->

		      </xsl:choose>
		    </xsl:if>
		    
		    <xsl:if test="not(./info/d)">
		      <xsl:attribute name="pos">
			<xsl:value-of select="'xxx'"/>
		      </xsl:attribute>
		    </xsl:if>
		    <xsl:value-of select="./sma"/>
		  </l>
		</lg>
		<mg>
		  <tg>
		    <t>
		      <xsl:attribute name="pos">
			<xsl:value-of select="'xxx'"/>
		      </xsl:attribute>
		      <xsl:value-of select="./nob"/>
		    </t>
		    <xsl:if test="./info/t">
		      <xg>
			<xsl:for-each select="./info/t">
			  <x>
			    <xsl:value-of select="."/>
			  </x>
			</xsl:for-each>
		      </xg>
		    </xsl:if>
		  </tg>
		</mg>
	      </e>
	    </xsl:for-each>
	  </r>
	</xsl:variable>
	
	
	
	<xsl:result-document href="{$outputDir}/{$file_name}.{$e}" format="{$output_format}">
	  <xsl:copy-of select="$dictionary"/>
	</xsl:result-document>
	
	
	
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>Cannot locate: </xsl:text><xsl:value-of select="$inputFile"/><xsl:text>&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>

