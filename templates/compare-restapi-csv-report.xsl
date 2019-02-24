<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
  xmlns:math="http://exslt.org/math"
  extension-element-prefixes="math"
  xmlns:date="http://exslt.org/dates-and-times">
  
  <xsl:output method="text" indent="yes" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" />

  <xsl:param    name="showData" select="'n'"/>
  <xsl:param    name="dateReport" select="date:date-time()"/>
  <xsl:param    name="testRunName" select="'date not defined'"/>
  <xsl:param    name="baselineTest" select="'date not defined'"/>
  <xsl:param    name="currentTest" select="'date not defined'"/>
  <xsl:param    name="testRes2" expression="'date not defined'"/>
  <xsl:variable name="percent-fail-factor" select="0.25" />
  <xsl:variable name="file2" select="document($testRes2)" />

  <xsl:template match="test">API_label,Status,Diff_Msec,Diff_Percent
<xsl:for-each select="/test/trx[contains(@label, '.') and not(contains(@label, 'Trx')) and not(@label = preceding::*/@label)]">
      <xsl:variable name="label1" select="@label" />
      <xsl:variable name="percentCur" select="@perc" /> 
      <xsl:variable name="percentBase" select="$file2/test/trx/../*[@label = current()/@label]/@perc"/>
      <xsl:variable name="diff-msec" select="$percentCur - $percentBase" />
      <xsl:variable name="diff-perc" select="((($percentCur - $percentBase) * 100) div $percentBase) div 100" />
      <xsl:value-of select="$label1" />,<xsl:call-template name="display-status"><xsl:with-param name="value" select="$diff-perc" /></xsl:call-template>,<xsl:value-of select="$diff-msec" />,<xsl:call-template name="display-percent"><xsl:with-param name="value" select="$diff-perc" /></xsl:call-template>,<xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="display-percent">
    <xsl:param name="value" />
    <xsl:value-of select="format-number($value,'0%')" />
  </xsl:template>

  <xsl:template name="display-status">
    <xsl:param name="value" />
    <xsl:choose>
<xsl:when test="$value &gt; 0.2">FAIL</xsl:when>
<xsl:otherwise>PASS</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
