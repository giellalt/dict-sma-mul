<?xml version="1.0"?>
<!--+
    | 
    | compares two lists of words and outputs both the intersection set
    | and the set of items which are in the first but not in the second set
    | NB: The user has to adjust the paths to the input files accordingly
    | Usage: java net.sf.saxon.Transform -it main THIS_FILE
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="xs">

  <xsl:strip-space elements="*"/>

  <xsl:output method="text" name="txt"
	      encoding="UTF-8"
	      omit-xml-declaration="yes"
	      indent="no"/>

  <xsl:output method="xml" name="xml"
              encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>

  <xsl:output method="xml" name="html"
              encoding="UTF-8"
              omit-xml-declaration="yes"
              indent="yes"/>

  <xsl:function name="cipx:isConsonant" as="xs:boolean" 
                xmlns:cipx="http://www.cipx.com" >
    <xsl:param name="arg" as="xs:string?"/>
    <xsl:variable name="consonants" select="'_b_d_f_g_h_j_k_l_m_n_p_r_s_t_v_x_’_'"/>
    <xsl:value-of select="contains($consonants, lower-case($arg))"/>
  </xsl:function>

  <xsl:function name="cipx:isVowel" as="xs:boolean" 
                xmlns:cipx="http://www.cipx.com" >
    <xsl:param name="arg" as="xs:string?"/>
    <xsl:variable name="vowels" select="'_a_e_i_o_u_y_å_æ_ï_ö_'"/>
    <xsl:value-of select="contains($vowels, lower-case($arg))"/>
  </xsl:function>
  
  
  
  <xsl:param name="lang" select="'sma'"/>
  <xsl:variable name="debug" select="true()"/>
  <xsl:variable name="of" select="'html'"/>
  <xsl:variable name="e" select="$of"/>
  <xsl:variable name="nl" select="'&#xa;'"/>

  <!-- input file, extention of the output file -->
  <xsl:param name="inFile" select="'_x_'"/>
  <xsl:param name="inDir" select="'_xxx_'"/>
  <xsl:param name="outDir" select="'_outData'"/>
  
  <xsl:template match="/" name="main">
    
    <xsl:for-each select="collection(concat($inDir, '?select=*.xml'))">
      
      <xsl:variable name="current_file" select="substring-before((tokenize(document-uri(.), '/'))[last()], '.xml')"/>
      <xsl:variable name="current_dir" select="substring-before(document-uri(.), $current_file)"/>
      <xsl:variable name="current_location" select="concat($inDir, substring-after($current_dir, $inDir))"/>
      
      <xsl:message terminate="no">
	<xsl:value-of select="concat('Processing file: ', $current_file, $nl)"/>
	<xsl:value-of select="concat('Location: ', $current_dir, $nl)"/>
      </xsl:message>
      
      <xsl:result-document href="{$outDir}/{$current_file}_out.{$e}" format="{$of}">
	<!--xsl:message terminate="no">
	  <xsl:value-of select="concat('sent ', ./@id)"/>
	</xsl:message-->

        <html>
          <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <title>South Saami Nouns with exactly two vowels/diphtongs</title>
          </head>
          <body>
            <h3>South Saami Nouns with exactly two vowels/diphtongs</h3>
	    
            <table class="sortable" border="1" cellpadding="10" cellspacing="0">
	      <tr><th>no.</th><th>lemma</th><th width="50px">translation</th><th width="50px">soggi</th><th width="50px">stem</th></tr>
	      <xsl:for-each select='./r/e[./lg/l[matches(normalize-space(.),"^([bdfghjklmnprstvx’]*)([aeiouyåæïö]+)([bdfghjklmnprstvx’]+)([aeiouyåæïö]+)([bdfghjklmnprstvx’]*)$")]]'>
		<xsl:message terminate="no">
		  <xsl:value-of select="concat('e: ', ./lg/l)"/>
		</xsl:message>
		<xsl:variable name="info">
		  <i>
		    <xsl:copy-of copy-namespaces="no" select="./lg/l/@*"/>
		    <xsl:attribute name="translation">
		      <xsl:variable name="all">
			<xsl:for-each select="./mg/tg[./@xml:lang='nob']/*[starts-with(./local-name(), 't')]">
			  <xsl:value-of select="concat(., '; ')"/>
			</xsl:for-each>
		      </xsl:variable>
		      <xsl:value-of select="substring($all, 1, string-length($all)-2)"/>
		    </xsl:attribute>
		  </i>
		</xsl:variable>
		
		<xsl:variable name="cLemma" select="normalize-space(./lg/l)"/>
		<tr>
		  <td><xsl:value-of select="position()"/></td>
		  <td><xsl:value-of select="$cLemma"/></td>
		  <td width="50px"><span style="font-style:italic; color:grey"><xsl:value-of select="$info/i/@translation"/></span></td>
		  <td width="50px"><xsl:value-of select="$info/i/@soggi"/></td>
		  <td width="50px"><xsl:value-of select="$info/i/@stem"/></td>
		</tr>
	      </xsl:for-each>
	    </table>
	  </body>
	</html>
      </xsl:result-document>
    </xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>
