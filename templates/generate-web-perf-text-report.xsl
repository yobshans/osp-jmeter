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
<xsl:param    name="testRes2" expression="'date not defined'"/>
<xsl:param    name="testDuration" select="'n/a'"/>
<xsl:param    name="numThreads" select="'n/a'"/>
<xsl:param    name="numIterations" select="'n/a'"/>
<xsl:param    name="ucSys" select="'n/a'"/>
<xsl:param    name="ucOs" select="'n/a'"/>
<xsl:param    name="ucCpu" select="'n/a'"/>
<xsl:param    name="ucMem" select="'n/a'"/>
<xsl:param    name="contrSys" select="'n/a'"/>
<xsl:param    name="contrOs" select="'n/a'"/>
<xsl:param    name="contrCpu" select="'n/a'"/>
<xsl:param    name="contrMem" select="'n/a'"/>
<xsl:param    name="compSys" select="'n/a'"/>
<xsl:param    name="compOs" select="'n/a'"/>
<xsl:param    name="compCpu" select="'n/a'"/>
<xsl:param    name="compMem" select="'n/a'"/>
<xsl:param    name="cephSys" select="'n/a'"/>
<xsl:param    name="cephOs" select="'n/a'"/>
<xsl:param    name="cephCpu" select="'n/a'"/>
<xsl:param    name="cephMem" select="'n/a'"/>
<xsl:param    name="contrCount" select="'n/a'"/>
<xsl:param    name="compCount" select="'n/a'"/>
<xsl:param    name="cephCount" select="'n/a'"/>
<xsl:param    name="perfMon" select="'n/a'"/>
<xsl:param    name="note" select="'n/a'"/>
<xsl:variable name="percent-fail-factor" select="0.1" />
<xsl:variable name="file2" select="document($testRes2)" />

<xsl:template match="testResults">
Openstack HTTP Horizon Performance Test Report:
  <xsl:variable name="allCount" select="count(sample)" />
  <xsl:variable name="allFailureCount" select="count(sample[attribute::s='false'])" />
  <xsl:variable name="allSuccessCount" select="count(sample[attribute::s='true'])" />
  <xsl:variable name="allSuccessPercent" select="$allSuccessCount div $allCount" />
  <xsl:variable name="allTotalTime" select="sum(sample/@t)" />
  <xsl:variable name="allAverageTime" select="$allTotalTime div $allCount" />
  <xsl:variable name="allMinTime">
    <xsl:call-template name="min"><xsl:with-param name="nodes" select="sample/@t" /></xsl:call-template>
  </xsl:variable>
  <xsl:variable name="allMaxTime">
    <xsl:call-template name="max"><xsl:with-param name="nodes" select="sample/@t" /></xsl:call-template>
  </xsl:variable>
  
  <xsl:variable name="slow1">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="$file2/test/trx[not(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="1" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="slow2">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="$file2/test/trx[not(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="2" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="slow3">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="$file2/test/trx[not(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="3" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="slow4">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="$file2/test/trx[not(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="4" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="slow5">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="$file2/test/trx[not(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="5" />
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="slowtrx1">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="$file2/test/trx[(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="1" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="slowtrx2">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="$file2/test/trx[(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="2" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="slowtrx3">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="$file2/test/trx[(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="3" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="slowtrx4">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="$file2/test/trx[(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="4" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="slowtrx5">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="$file2/test/trx[(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="5" />
    </xsl:call-template>
  </xsl:variable>
-----------------------------------------------------------------------------------------

Openstack Version: <xsl:value-of select="$buildNum" />
Date Report: <xsl:value-of select="$dateReport" />
Test Run Name: <xsl:value-of select="$testRunName" />
Test Duration: <xsl:value-of select="$testDuration" />
1 X Undercloud Node: System - <xsl:value-of select="$ucSys" />, OS - <xsl:value-of select="$ucOs" />, CPU - <xsl:value-of select="$ucCpu" />, RAM - <xsl:value-of select="$ucMem" />.
<xsl:value-of select="$contrCount" /> X Controller Node: System - <xsl:value-of select="$contrSys" />, OS - <xsl:value-of select="$contrOs" />, CPU - <xsl:value-of select="$contrCpu" />, RAM - <xsl:value-of select="$contrMem" />.
<xsl:value-of select="$compCount" /> X Compute Node: System - <xsl:value-of select="$compSys" />, OS - <xsl:value-of select="$compOs" />, CPU - <xsl:value-of select="$compCpu" />, RAM - <xsl:value-of select="$compMem" />.
<xsl:value-of select="$cephCount" /> X Ceph Node: System - <xsl:value-of select="$cephSys" />, OS - <xsl:value-of select="$cephOs" />, CPU - <xsl:value-of select="$cephCpu" />, RAM - <xsl:value-of select="$cephMem" />.
-----------------------------------------------------------------------------------------
Notes: <xsl:value-of select="$note" />
-----------------------------------------------------------------------------------------

Success Rate: Passed - <xsl:value-of select="$allSuccessCount" /> | Failed - <xsl:value-of select="$allFailureCount" />
Response Time: Minimum - <xsl:call-template name="display-time"><xsl:with-param name="value" select="$allMinTime" /></xsl:call-template> | Average - <xsl:call-template name="display-time"><xsl:with-param name="value" select="$allAverageTime" /></xsl:call-template> | Maximum - <xsl:call-template name="display-time"><xsl:with-param name="value" select="$allMaxTime" /></xsl:call-template>

Top 5 Worst HTTP Requests Response Time:

<xsl:call-template name="maxlabel">
  <xsl:with-param name="nodes" select="$file2/test/trx[contains(@label, '.') and not(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="1" />
</xsl:call-template>&#160;&#x2212;&#160;<xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow1" /></xsl:call-template><xsl:text>&#xa;</xsl:text>
<xsl:call-template name="maxlabel">
  <xsl:with-param name="nodes" select="$file2/test/trx[contains(@label, '.') and not(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="2" />
</xsl:call-template>&#160;&#x2212;&#160;<xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow2" /></xsl:call-template><xsl:text>&#xa;</xsl:text>
<xsl:call-template name="maxlabel">
  <xsl:with-param name="nodes" select="$file2/test/trx[contains(@label, '.') and not(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="3" />
</xsl:call-template>&#160;&#x2212;&#160;<xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow3" /></xsl:call-template><xsl:text>&#xa;</xsl:text>
<xsl:call-template name="maxlabel">
  <xsl:with-param name="nodes" select="$file2/test/trx[contains(@label, '.') and not(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="4" />
</xsl:call-template>&#160;&#x2212;&#160;<xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow4" /></xsl:call-template><xsl:text>&#xa;</xsl:text>
<xsl:call-template name="maxlabel">
  <xsl:with-param name="nodes" select="$file2/test/trx[contains(@label, '.') and not(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="5" />
</xsl:call-template>&#160;&#x2212;&#160;<xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow5" /></xsl:call-template><xsl:text>&#xa;</xsl:text>
Top 5 Worst HTTP Transactions Response Time:

<xsl:call-template name="maxlabel">
  <xsl:with-param name="nodes" select="$file2/test/trx[contains(@label, '.') and (contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="1" />
</xsl:call-template>&#160;&#x2212;&#160;<xsl:call-template name="display-time"><xsl:with-param name="value" select="$slowtrx1" /></xsl:call-template><xsl:text>&#xa;</xsl:text>
<xsl:call-template name="maxlabel">
  <xsl:with-param name="nodes" select="$file2/test/trx[contains(@label, '.') and (contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="2" />
</xsl:call-template>&#160;&#x2212;&#160;<xsl:call-template name="display-time"><xsl:with-param name="value" select="$slowtrx2" /></xsl:call-template><xsl:text>&#xa;</xsl:text>
<xsl:call-template name="maxlabel">
  <xsl:with-param name="nodes" select="$file2/test/trx[contains(@label, '.') and (contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="3" />
</xsl:call-template>&#160;&#x2212;&#160;<xsl:call-template name="display-time"><xsl:with-param name="value" select="$slowtrx3" /></xsl:call-template><xsl:text>&#xa;</xsl:text>
<xsl:call-template name="maxlabel">
  <xsl:with-param name="nodes" select="$file2/test/trx[contains(@label, '.') and (contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="4" />
</xsl:call-template>&#160;&#x2212;&#160;<xsl:call-template name="display-time"><xsl:with-param name="value" select="$slowtrx4" /></xsl:call-template><xsl:text>&#xa;</xsl:text>
<xsl:call-template name="maxlabel">
  <xsl:with-param name="nodes" select="$file2/test/trx[contains(@label, '.') and (contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="5" />
</xsl:call-template>&#160;&#x2212;&#160;<xsl:call-template name="display-time"><xsl:with-param name="value" select="$slowtrx5" /></xsl:call-template><xsl:text>&#xa;</xsl:text>
---------------------------------------------------------------------------------------------------------------------------
| HTTP Requests Response Time: 
---------------------------------------------------------------------------------------------------------------------------
| HTTP Requests 	    | Count | Failures | Success Rate | Average Time | 90% Line Time | Min Time | Max Time |
---------------------------------------------------------------------------------------------------------------------------
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
| <xsl:value-of select="$label" /> | <xsl:value-of select="$count" /> | <xsl:value-of select="$failureCount" /> | <xsl:call-template name="display-percent"><xsl:with-param name="value" select="$successPercent" /></xsl:call-template> | <xsl:call-template name="display-time"><xsl:with-param name="value" select="$averageTime" /></xsl:call-template> | <xsl:call-template name="display-time"><xsl:with-param name="value" select="$percent" /></xsl:call-template> | <xsl:call-template name="display-time"><xsl:with-param name="value" select="$minTime" /></xsl:call-template> | <xsl:call-template name="display-time"><xsl:with-param name="value" select="$maxTime" /></xsl:call-template> |
------------------------------------------------------------------------------------------------------------------------
  </xsl:for-each>
<xsl:text>&#xa;</xsl:text>
---------------------------------------------------------------------------------------------------------------------------
| HTTP Transactions Response Time: 
------------------------------------------------------------------------------------------------------------------------
| HTTP Requests 	    | Count | Failures | Success Rate | Average Time | 90% Line Time | Min Time | Max Time |
---------------------------------------------------------------------------------------------------------------------------
<xsl:for-each select="sample[contains(@lb, '.') and (contains(@lb, 'Trx')) and not(@lb = preceding::*/@lb)]">
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
| <xsl:value-of select="$label" /> | <xsl:value-of select="$count" /> | <xsl:value-of select="$failureCount" /> | <xsl:call-template name="display-percent"><xsl:with-param name="value" select="$successPercent" /></xsl:call-template> | <xsl:call-template name="display-time"><xsl:with-param name="value" select="$averageTime" /></xsl:call-template> | <xsl:call-template name="display-time"><xsl:with-param name="value" select="$percent" /></xsl:call-template> | <xsl:call-template name="display-time"><xsl:with-param name="value" select="$minTime" /></xsl:call-template> | <xsl:call-template name="display-time"><xsl:with-param name="value" select="$maxTime" /></xsl:call-template> |
------------------------------------------------------------------------------------------------------------------------
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

<xsl:template name="maxlabel">
  <xsl:param name="nodes" select="/.." />
  <xsl:param name="pos" />
    <xsl:for-each select="$nodes">
      <xsl:sort select = "@perc" data-type="number" order="descending" />
	<xsl:if test="position() = $pos">
	  <xsl:value-of select="@label" />
	</xsl:if>
    </xsl:for-each>
</xsl:template>

<xsl:template name="maxtime">
  <xsl:param name="nodes" select="/.." />
  <xsl:param name="pos" />
    <xsl:for-each select="$nodes">
      <xsl:sort select = "@perc" data-type="number" order="descending" />
	<xsl:if test="position() = $pos">
	  <xsl:value-of select="@perc" />
	</xsl:if>
    </xsl:for-each>
</xsl:template>

<xsl:template name="display-percent">
	<xsl:param name="value" />
	<xsl:value-of select="format-number($value,'0.00%')" />
</xsl:template>

<xsl:template name="display-time">
	<xsl:param name="value" />
	<xsl:value-of select="format-number($value,'0 ms')" />
</xsl:template>
	
</xsl:stylesheet>
