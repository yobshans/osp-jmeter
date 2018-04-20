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
<xsl:param    name="perfMon" select="'n/a'"/>
<xsl:variable name="percent-fail-factor" select="0.3" />
<xsl:variable name="file2" select="document($testRes2)" />

<xsl:template match="testResults">
<html>
<head>
<title>Openstack Horizon Web Performance Test Comparison Report</title>
<link rel="stylesheet" href="html/result.css" type="text/css" />
<style type="text/css">
</style>
</head>
<body>
  <xsl:call-template name="pageHeader" />
  <xsl:call-template name="pageBody" />
</body>
</html>
</xsl:template>

<xsl:template name="pageHeader">
  <div class="header" align="center">
  <a id="openstack" href="https://www.openstack.org/"><img alt="Openstack" src="img/openstack-logo.svg" height="50" width="200"></img></a>
  </div>

  <xsl:if test="$perfMon='true' or $perfMon='True'">
    <div class="topnav">
      <a class="active" href="index.html">Summary Report</a>
      <a href="html/api.html">HTTP Requests Response Time Report</a>
      <a href="html/trx.html">Transactions Elapsed Time Report</a>
      <a href="html/cpu.html">CPU Utilization Report</a>
      <a href="html/mem.html">Memory Utilization Report</a>
      <a href="html/net.html">Network Utilization Report</a>
      <a href="html/disk.html">Disk Utilization Report</a>
    </div>
  </xsl:if>
  <xsl:if test="$perfMon='false' or $perfMon='False'">
    <div class="topnav">
      <a class="active" href="index.html">Summary Report</a>
      <a href="html/api.html">HTTP Requests Response Time Report</a>
      <a href="html/trx.html">Transactions Elapsed Time Report</a>
    </div>
  </xsl:if>

</xsl:template>

<xsl:template name="pageBody">

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
	
  <xsl:variable name="pi" select="math:constant('PI',10)" />
  <xsl:variable name="mashtab" select="$slow1 div 500" />
  <xsl:variable name="mashtabtrx" select="$slowtrx1 div 500" />
    
  <xsl:variable name="passangle" select="$allSuccessCount * 360 div $allCount" />
  <xsl:variable name="pass_rx" select="math:cos(($passangle div 360) * 2 * $pi)" />
  <xsl:variable name="pass_ry" select="math:sin(($passangle div 360) * 2 * $pi)" />
  <xsl:variable name="pass_x" select="120 - ($pass_rx * 120)" />
  <xsl:variable name="pass_y" select="120 - ($pass_ry * 120)" />
  <xsl:variable name="failamount" select="$allCount" />
  <xsl:variable name="failangle" select="$failamount * 360 div $allCount" />
  <xsl:variable name="fail_rx" select="math:cos(($failangle div 360) * 2 * $pi)" />
  <xsl:variable name="fail_ry" select="math:sin(($failangle div 360) * 2 * $pi)" />
  <xsl:variable name="fail_x" select="120 - ($fail_rx * 120)" />
  <xsl:variable name="fail_y" select="120 - ($fail_ry * 120)" />

  <div class="body">
    <h3 align="center">Openstack Horizon Web Performance Test Comparison Report</h3>
    <hr size="1" />

    <table align="center" class="details" border="0" cellpadding="2" cellspacing="2" width="95%">
      <tr valign="top">
	<th align="left">Baseline Test - <a href="{$baselineTest}/index.html" target="_blank"><xsl:value-of select="$baselineTest"/></a> - Success Rate:</th>
	<th align="left">Top 5 Worst HTTP Requests Response Time 90% Line:</th>
	<th align="left">Top 5 Worst Transactions Elapsed Time 90% Line:</th>
      </tr>
      <tr>
	<td>
	  <svg height="295px" width="100%" >
	    <g id="bar" transform="translate(100,50)">
	      <xsl:choose>
		<xsl:when test="$allSuccessCount = $allCount">
		  <circle cx="120" cy="120" r="120" stroke="black" stroke-width="1" fill="#00FF00" />
		</xsl:when>
		<xsl:otherwise>
		  <path d="M120,120 L0,120 A120,120 0 1,1 {$pass_x},{$pass_y} Z" style="fill:#00FF00;stroke: black;stroke-width: 1"/>
		  <path d="M120,120 L{$pass_x},{$pass_y} A120,120 0 0,1 {$fail_x},{$fail_y} Z" style="fill:#FF0000;stroke: black;stroke-width: 1"/>
		</xsl:otherwise>
	      </xsl:choose>
	    </g>
	    <text x="185" y="125">
	      <xsl:call-template name="display-percent"><xsl:with-param name="value" select="$allSuccessPercent" /></xsl:call-template>
	    </text>
	    <text x="350" y="125" >Passed: <xsl:value-of select="$allSuccessCount" /></text>
	    <text x="25" y="250" >Failed: <xsl:value-of select="$allFailureCount" /></text>
	  </svg>
	</td>
	<td>
	  <svg height="295px" width="100%">
	    <g id="bar" transform="translate(0,0)">
	    <rect x="{position()*25}" y="{position()*70}" height="25" width="{$slow1 div $mashtab}" style="fill:#FF0000;"/> <!-- red -->
	    <text x="{position()*25}" y="{position()*70-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="$file2/test/trx[not(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="1" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow1" /></xsl:call-template>
	    </text>
	    <rect x="{position()*25}" y="{position()*120}" height="25" width="{$slow2 div $mashtab}" style="fill:#DC143C;"/><!-- crimson -->
	    <text x="{position()*25}" y="{position()*120-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="$file2/test/trx[not(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="2" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow2" /></xsl:call-template>
	    </text>
	    <rect x="{position()*25}" y="{position()*170}" height="25" width="{$slow3 div $mashtab}" style="fill:#DB7093;"/><!-- palevioletred -->
	    <text x="{position()*25}" y="{position()*170-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="$file2/test/trx[not(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="3" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow3" /></xsl:call-template>
	    </text>
	    <rect x="{position()*25}" y="{position()*220}" height="25" width="{$slow4 div $mashtab}" style="fill:#F08080;"/><!-- lightcoral -->
	    <text x="{position()*25}" y="{position()*220-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="$file2/test/trx[not(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="4" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow4" /></xsl:call-template>
	    </text>
	    <rect x="{position()*25}" y="{position()*270}" height="25" width="{$slow5 div $mashtab}" style="fill:#FFA07A;"/><!-- lightsalmon -->
	    <text x="{position()*25}" y="{position()*270-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="$file2/test/trx[not(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="5" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow5" /></xsl:call-template>
	    </text>
	  </g>
	</svg>
	</td>
	<td>
	  <svg xmlns="http://www.w3.org/2000/svg" height="295px" width="100%">
	    <g id="bar" transform="translate(0,0)">
	    <rect x="{position()*25}" y="{position()*70}" height="25" width="{$slowtrx1 div $mashtabtrx}" style="fill:#800080;"/> <!-- Purple -->
	    <text x="{position()*25}" y="{position()*70-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="$file2/test/trx[(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="1" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slowtrx1" /></xsl:call-template>
	    </text>
	    <rect x="{position()*25}" y="{position()*120}" height="25" width="{$slowtrx2 div $mashtabtrx}" style="fill:#FF00FF;"/><!-- Fuchsia -->
	    <text x="{position()*25}" y="{position()*120-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="$file2/test/trx[(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="2" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slowtrx2" /></xsl:call-template>
	    </text>
	    <rect x="{position()*25}" y="{position()*170}" height="25" width="{$slowtrx3 div $mashtabtrx}" style="fill:#000080;"/><!-- Navy -->
	    <text x="{position()*25}" y="{position()*170-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="$file2/test/trx[(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="3" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slowtrx3" /></xsl:call-template>
	    </text>
	    <rect x="{position()*25}" y="{position()*220}" height="25" width="{$slowtrx4 div $mashtabtrx}" style="fill:#0000FF;"/><!-- Blue -->
	    <text x="{position()*25}" y="{position()*220-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="$file2/test/trx[(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="4" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slowtrx4" /></xsl:call-template>
	    </text>
	    <rect x="{position()*25}" y="{position()*270}" height="25" width="{$slowtrx5 div $mashtabtrx}" style="fill:#00FFFF;"/><!-- Aqua -->
	    <text x="{position()*25}" y="{position()*270-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="$file2/test/trx[(contains(@label, 'Trx'))]" /><xsl:with-param name="pos" select="5" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slowtrx5" /></xsl:call-template>
	    </text>
	  </g>
	</svg>
	</td>
      </tr>
    </table>
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
	<xsl:value-of select="format-number($value,'#,### ms')" />
</xsl:template>
	
</xsl:stylesheet>
