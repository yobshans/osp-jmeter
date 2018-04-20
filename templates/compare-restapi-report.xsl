<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
  xmlns:math="http://exslt.org/math"
  extension-element-prefixes="math"
  xmlns:date="http://exslt.org/dates-and-times">
  
<xsl:output method="html" indent="yes" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" />

<xsl:param    name="showData" select="'n'"/>
<xsl:param    name="dateReport" select="date:date-time()"/>
<xsl:param    name="testRunName" select="'date not defined'"/>
<xsl:param    name="baselineTest" select="'date not defined'"/>
<xsl:param    name="currentTest" select="'date not defined'"/>
<xsl:param    name="testRes2" expression="'date not defined'"/>
<xsl:param    name="perfMon" select="'n'"/>
<xsl:variable name="percent-fail-factor" select="0.2" />
<xsl:variable name="file2" select="document($testRes2)" />

<xsl:template match="test">
<html>
<head>
<title>REST API Calls Response Time Report</title>
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
      <a class="active" href="api.html">REST API Calls Response Time Report</a>
      <a href="trx.html">Transactions Elapsed Time Report</a>
      <a href="cpu.html">CPU Utilization Report</a>
      <a href="mem.html">Memory Utilization Report</a>
      <a href="net.html">Network Utilization Report</a>
      <a href="disk.html">Disk Utilization Report</a>
    </div>
  </xsl:if>
  <xsl:if test="$perfMon='false' or $perfMon='False'">
    <div class="topnav">
      <a href="../index.html">Summary Report</a>
      <a class="active" href="api.html">REST API Calls Response Time Report</a>
      <a href="trx.html">Transactions Elapsed Time Report</a>
    </div>
  </xsl:if>
  
</xsl:template>

<xsl:template name="pageBody">

  <div class="body">
    <h3 align="center">REST API Calls Response Time Report</h3>
    <hr size="1" />

    <table align="center" class="details" border="0" cellpadding="5" cellspacing="2" width="95%">
      <tr valign="top">
	<th>Click to view Chart</th>
	<th>REST APIs Name</th>
	<th>Baseline Test - 90% Line Time</th>
	<th>Current Test - 90% Line Time</th>
	<th>Difference (msec)</th>
	<th>Difference (%)</th>
      </tr>
      <xsl:for-each select="/test/trx[contains(@label, '.') and not(contains(@label, 'Trx')) and not(@label = preceding::*/@label)]">
	<xsl:variable name="label1" select="@label" />
	<xsl:variable name="percentCur" select="@perc" /> 
	<xsl:variable name="percentBase" select="$file2/test/trx/../*[@label = current()/@label]/@perc"/>
	<xsl:variable name="diff-msec" select="$percentCur - $percentBase" />
	<xsl:variable name="diff-perc" select="((($percentCur - $percentBase) * 100) div $percentBase) div 100" />

	<tr valign="top">
	  <xsl:attribute name="class">
	    <xsl:if test="$diff-perc &gt; $percent-fail-factor">Failure</xsl:if>
	    <xsl:if test="$diff-perc &lt; 0 - $percent-fail-factor">Passed</xsl:if>
	  </xsl:attribute>
	  <td align="center">
	    <div class="popup" onclick="popupChart('{$label1}')"><img width="25px" height="25px" src="../img/{$label1}-mrg.png" />
	      <span class="popuptext"  id="{$label1}" ><img src="../img/{$label1}-mrg.png" /></span>
	    </div>
	  </td>
	  <td align="left"><xsl:value-of select="$label1" /></td>
	  <td align="center"><xsl:call-template name="display-time"><xsl:with-param name="value" select="$percentBase" /></xsl:call-template></td>
	  <td align="center"><xsl:call-template name="display-time"><xsl:with-param name="value" select="$percentCur" /></xsl:call-template></td>
	  <td align="center"><xsl:call-template name="display-time"><xsl:with-param name="value" select="$diff-msec" /></xsl:call-template></td>
	  <td align="center"><xsl:call-template name="display-percent">	<xsl:with-param name="value" select="$diff-perc" /></xsl:call-template></td>
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

<xsl:template name="display-percent">
	<xsl:param name="value" />
	<xsl:value-of select="format-number($value,'0.00%')" />
</xsl:template>

<xsl:template name="display-time">
	<xsl:param name="value" />
	<xsl:value-of select="format-number($value,'#,### ms')" />
</xsl:template>
	
</xsl:stylesheet>