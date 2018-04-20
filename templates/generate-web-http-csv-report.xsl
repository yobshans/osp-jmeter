<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
  xmlns:math="http://exslt.org/math"
  extension-element-prefixes="math"
  xmlns:date="http://exslt.org/dates-and-times">
  
<xsl:output method="text" indent="yes" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" />

<xsl:param    name="showData" select="'n'"/>
<xsl:param    name="dateReport" select="date:date-time()"/>
<xsl:param    name="buildNum" select="'date not defined'"/>
<xsl:param    name="testRunName" select="'date not defined'"/>

<xsl:template match="testResults">
HTTP Request,count,average,90,min,max
    <xsl:for-each select="sample[contains(@lb, '.') and not(contains(@lb, 'Trx')) and not(@lb = preceding::*/@lb)]">
      <xsl:variable name="label" select="@lb" />
      <xsl:variable name="count" select="count(../*[@lb = current()/@lb])" />
      <xsl:variable name="failureCount" select="count(../*[@lb = current()/@lb][attribute::s='false'])" />
      <xsl:variable name="successCount" select="count(../*[@lb = current()/@lb][attribute::s='true'])" />
      <xsl:variable name="successPercent" select="$successCount div $count" />
      <xsl:variable name="totalTime" select="sum(../*[@lb = current()/@lb]/@t)" />
      <xsl:variable name="averageTime" select="$totalTime div $count" />
      <xsl:variable name="percent">
	<xsl:call-template name="percentiles"><xsl:with-param name="nodes" select="../*[@lb = current()/@lb]/@t" /></xsl:call-template>
      </xsl:variable>
      <xsl:variable name="minTime">
	<xsl:call-template name="min"><xsl:with-param name="nodes" select="../*[@lb = current()/@lb]/@t" /></xsl:call-template>
      </xsl:variable>
      <xsl:variable name="maxTime">
	<xsl:call-template name="max"><xsl:with-param name="nodes" select="../*[@lb = current()/@lb]/@t" /></xsl:call-template>
      </xsl:variable>
<xsl:value-of select="$label" />,<xsl:value-of select="$count" />,<xsl:value-of select="$averageTime" />,<xsl:value-of select="$percent" />,<xsl:value-of select="$minTime" />,<xsl:value-of select="$maxTime" /><xsl:text>&#xa;</xsl:text>
</xsl:for-each>

</xsl:template>

<xsl:template name="min">
	<xsl:param name="nodes" select="/.." />
	<xsl:choose>
		<xsl:when test="not($nodes)">NaN</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="$nodes">
				<xsl:sort data-type="number" />
				<xsl:if test="position() = 1">
					<xsl:value-of select="number(.)" />
				</xsl:if>
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="max">
	<xsl:param name="nodes" select="/.." />
	<xsl:choose>
		<xsl:when test="not($nodes)">NaN</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="$nodes">
				<xsl:sort data-type="number" order="descending" />
				<xsl:if test="position() = 1">
					<xsl:value-of select="number(.)" />
				</xsl:if>
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="percentiles">
	<xsl:param name="nodes" select="/.." />
		<xsl:variable name="allcount" select="count($nodes)" />
		<xsl:variable name="Lcount" select="round($allcount div 1.11)" />
		<xsl:for-each select="$nodes">
			<xsl:sort data-type="number" />
				<xsl:if test="position() = $Lcount">
					<xsl:value-of select="number(.)" />
				</xsl:if>
		</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
