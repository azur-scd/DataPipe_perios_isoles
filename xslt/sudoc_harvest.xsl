<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:param name="rcr" select="$rcr" />
    <xsl:template match="/*">
    <root>
       <xsl:for-each select="ppn">
            <item>
         <ppn>
            <xsl:value-of select="."/>
         </ppn>
         <xsl:apply-templates select="document(concat('https://www.sudoc.fr/',.,'.xml'))//record/datafield[starts-with(@tag, '9')]"/>
      </item>
      </xsl:for-each>
      </root>
    </xsl:template>
  <xsl:template match="record/datafield[starts-with(@tag, '9')]">
      <xsl:if test="./subfield[@code='p'] = 'NI' and starts-with(./subfield[@code='5'], $rcr)">
     <xsl:variable name="bu" select="./preceding-sibling::datafield[@tag='930'][1]/subfield[@code='c']" />
     <xsl:variable name="loc" select="./preceding-sibling::datafield[@tag='930'][1]/subfield[@code='d']" />
     <xsl:variable name="cote" select="./preceding-sibling::datafield[@tag='930'][1]/subfield[@code='a']" />
     <xsl:variable name="coll" select="./preceding-sibling::datafield[@tag='955'][1]/subfield[@code='r']" />
     <bu><xsl:value-of select="$bu" /></bu>
     <loc><xsl:value-of select="$loc" /></loc>
     <cote><xsl:value-of select="$cote" /></cote>
     <coll><xsl:value-of select="$coll" /></coll>
      </xsl:if>
  </xsl:template>
</xsl:stylesheet>


<!--
xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:param name="rcr" select="$rcr" />
    <xsl:template match="/*">  
      <root> 
         <xsl:for-each select="ppn">
            <item>
               <xsl:variable name="ppn" select="."/>
               <xsl:variable name="record">
                  <xsl:copy-of select="document(concat('https://www.sudoc.fr/',$ppn,'.xml'))"/>
               </xsl:variable>
               <ppn>
                  <xsl:value-of select="$record//controlfield[@tag='001']"/>
               </ppn>
               <xsl:call-template name="copyunimarc">
                  <xsl:with-param name="record" select="$record"/>
               </xsl:call-template>
            </item>
         </xsl:for-each>
      </root>
    </xsl:template>

     <xsl:template name="copyunimarc">
      <xsl:param name="record"/>
      <xsl:for-each select="$record//datafield[@tag='999']">
         <xsl:if test="subfield[@code='p'] = 'NI' and starts-with(subfield[@code='5'], $rcr)">
            <bu>
               <xsl:value-of select="./preceding-sibling::datafield[@tag='930'][1]/subfield[@code='c']"/>
            </bu>
             <loc>
            <xsl:value-of select="./preceding-sibling::datafield[@tag='930'][1]/subfield[@code='d']"/>
         </loc>
        <cote>
           <xsl:value-of select="./preceding-sibling::datafield[@tag='930'][1]/subfield[@code='a']"/>
        </cote>
        <coll>
           <xsl:value-of select="./preceding-sibling::datafield[@tag='955'][1]/subfield[@code='r']"/>
        </coll>
         </xsl:if>
      </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>

-->
