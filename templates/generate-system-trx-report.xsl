<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
  xmlns:math="http://exslt.org/math"
  extension-element-prefixes="math"
  xmlns:date="http://exslt.org/dates-and-times">
  
<xsl:output method="html" indent="yes" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" />

<xsl:param    name="showData" select="'n'"/>
<xsl:param    name="dateReport" select="date:date-time()"/>
<xsl:param    name="tabName" expression="'date not defined'"/>
<xsl:param    name="perfMon" select="'n'"/>
<xsl:variable name="percent-fail-factor" select="0.1" />

<xsl:template match="testResults">
<html>
<head>
<title>Transactions Elapsed Time Report</title>
<link rel="stylesheet" href="../html/result.css" type="text/css" />
<style type="text/css">
</style>
<script language="JavaScript"><![CDATA[

  function popupChart(popup_id) {
    var popup = document.getElementById(popup_id);
      popup.classList.toggle("show");
  }
  
]]></script>
</head>
<body>
  <xsl:call-template name="pageHeader" />
  <xsl:call-template name="pageBody" />
  <xsl:call-template name="pageFooter" />
</body>
</html>
</xsl:template>

<xsl:template name="pageHeader">
  <div class="header" align="center">
  <a id="openstack" href="https://www.openstack.org/"><img alt="Openstack" src="../img/openstack-logo.svg" height="50" width="200"></img></a>
  </div>

  <xsl:if test="$perfMon='true' or $perfMon='True'">
    <div class="topnav">
      <a href="../index.html">Summary Report</a>
      <a href="api.html"><xsl:value-of select="$tabName" /></a>
      <a class="active" href="trx.html">Transactions Elapsed Time Report</a>
      <a href="ssh.html">SSH Commands Report</a>
      <a href="cpu.html">CPU Utilization Report</a>
      <a href="mem.html">Memory Utilization Report</a>
      <a href="net.html">Network Utilization Report</a>
      <a href="disk.html">Disk Utilization Report</a>
    </div>
  </xsl:if>
  <xsl:if test="$perfMon='false' or $perfMon='False'">
    <div class="topnav">
      <a href="../index.html">Summary Report</a>
      <a href="api.html"><xsl:value-of select="$tabName" /></a>
      <a class="active" href="trx.html">Transactions Elapsed Time Report</a>
      <a href="ssh.html">SSH Commands Report</a>
    </div>
  </xsl:if>

</xsl:template>

<xsl:template name="pageBody">

  <div class="body">
    <h3>Transactions Elapsed Time Report</h3>
    <hr size="1" />

    <table width="95%" cellspacing="2" cellpadding="5" border="0" class="details" align="center">
    <tr valign="top">
      <th>Click to view Chart</th>
      <th>Transactions</th>
      <th>Count</th>
      <th>Failures</th>
      <th>Success Rate</th>
      <th>Average Time</th>
      <th>90% Line Time</th>
      <th>Min Time</th>
      <th>Max Time</th>
    </tr>

    <xsl:for-each select="sample[contains(@lb, 'Trx') and not(contains(@lb, 'setUp')) and not(contains(@lb, 'tearDown')) and not(@lb = preceding::*/@lb)]">
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

      <tr valign="top">
	<xsl:attribute name="class">
	  <xsl:choose>
	    <xsl:when test="$failureCount &gt; 0">Failure</xsl:when>
	  </xsl:choose>
	</xsl:attribute>
	<td align="center">
	  <div class="popup" onclick="popupChart('{$label}')"><img width="25px" height="25px" src="../img/{$label}.png" />
	    <span class="popuptext"  id="{$label}" ><img src="../img/{$label}.png" /></span>
	  </div>
	</td>
	<td align="left"><xsl:value-of select="$label" /></td>
	<td align="center"><xsl:value-of select="$count" /></td>
	<td align="center"><xsl:value-of select="$failureCount" /></td>
	<td align="center"><xsl:call-template name="display-percent"><xsl:with-param name="value" select="$successPercent" /></xsl:call-template></td>
	<td align="center"><xsl:call-template name="display-time"><xsl:with-param name="value" select="$averageTime" /></xsl:call-template></td>
	<td align="center"><xsl:call-template name="display-time"><xsl:with-param name="value" select="$percent" /></xsl:call-template></td>
	<td align="center"><xsl:call-template name="display-time"><xsl:with-param name="value" select="$minTime" /></xsl:call-template></td>
	<td align="center"><xsl:call-template name="display-time"><xsl:with-param name="value" select="$maxTime" /></xsl:call-template></td>
      </tr>
    </xsl:for-each>
    </table>
  </div>

</xsl:template>

<xsl:template name="pageFooter">
  <div class="footer" align="right">
  <a id="jmeter" href="http://jmeter.apache.org/"><img alt="JMeter" src="../img/jmeter-logo.svg" height="40" width="160"></img></a>
  </div>
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

<xsl:template name="display-percent">
	<xsl:param name="value" />
	<xsl:value-of select="format-number($value,'0.00%')" />
</xsl:template>

<xsl:template name="display-time">
	<xsl:param name="value" />
	<xsl:value-of select="format-number($value,'#,### ms')" />
</xsl:template>
	
</xsl:stylesheet>
