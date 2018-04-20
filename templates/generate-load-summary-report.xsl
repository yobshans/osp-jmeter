<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
  xmlns:math="http://exslt.org/math"
  extension-element-prefixes="math"
  xmlns:date="http://exslt.org/dates-and-times">
  
<xsl:output method="html" indent="yes" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" />

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
<xsl:param    name="note" select="'n/a'"/>
<xsl:param    name="perfMon" select="'n/a'"/>
<xsl:variable name="percent-fail-factor" select="0.1" />
<xsl:variable name="file2" select="document($testRes2)" />

<xsl:template match="testResults">
<html>
<head>
<title>Openstack REST API Performance Test Report</title>
<link rel="stylesheet" href="html/result.css" type="text/css" />
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
  <a id="openstack" href="https://www.openstack.org/"><img alt="Openstack" src="img/openstack-logo.svg" height="50" width="200"></img></a>
  </div>

  <xsl:if test="$perfMon='true' or $perfMon='True'">
    <div class="topnav">
      <a class="active" href="index.html">Summary Report</a>
      <a href="html/api.html">REST API Calls Response Time Report</a>
      <a href="html/ssh.html">SSH Commands Report</a>
      <a href="html/cpu.html">CPU Utilization Report</a>
      <a href="html/mem.html">Memory Utilization Report</a>
      <a href="html/net.html">Network Utilization Report</a>
      <a href="html/disk.html">Disk Utilization Report</a>
    </div>
  </xsl:if>
  <xsl:if test="$perfMon='false' or $perfMon='False'">
    <div class="topnav">
      <a class="active" href="index.html">Summary Report</a>
      <a href="html/api.html">REST API Calls Response Time Report</a>
      <a href="html/ssh.html">SSH Commands Report</a>
    </div>
  </xsl:if>

</xsl:template>

<xsl:template name="pageBody">

  <xsl:variable name="allCount" select="count(httpSample)" />
  <xsl:variable name="allFailureCount" select="count(httpSample[attribute::s='false'])" />
  <xsl:variable name="allSuccessCount" select="count(httpSample[attribute::s='true'])" />
  <xsl:variable name="allSuccessPercent" select="$allSuccessCount div $allCount" />
  <xsl:variable name="allTotalTime" select="sum(httpSample/@t)" />
  <xsl:variable name="allAverageTime" select="$allTotalTime div $allCount" />
  <xsl:variable name="allMinTime">
    <xsl:call-template name="min"><xsl:with-param name="nodes" select="httpSample/@t" /></xsl:call-template>
  </xsl:variable>
  <xsl:variable name="allMaxTime">
    <xsl:call-template name="max"><xsl:with-param name="nodes" select="httpSample/@t" /></xsl:call-template>
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
    <h3 align="center">Openstack REST API Performance Test Report</h3>
    <hr size="1" />

    <table align="center" class="details" border="0" cellpadding="5" cellspacing="2" width="95%">
      <tr valign="top">
	<th>Openstack Version:</th>
	<th>Date Report:</th>
	<th>Test Run Name:</th>
	<th>Test Duration:</th>
	<th>Test Load Schema:</th>
	<th>Test Iterations:</th>
      </tr>
      <tr valign="top">
	<td align="center"><xsl:value-of select="$buildNum" /></td>
	<td align="center"><xsl:value-of select="$dateReport" /></td>
	<td align="center"><xsl:value-of select="$testRunName" /></td>
	<td align="center"><xsl:value-of select="$testDuration" /></td>
	<td align="center"><xsl:value-of select="$numThreads" /></td>
	<td align="center"><xsl:value-of select="$numIterations" /></td>
      </tr>
    </table>
    <hr size="1" />
    <table align="center" class="details" border="0" cellpadding="5" cellspacing="2" width="95%">
      <tr valign="top">
	<th>Overcloud Stack Status</th>
	<th>STRESS-NG Statistics</th>
	<th>IPERF Statistics</th>
      </tr>
      <tr valign="top">
	<td align="center">
	  <div class="popup" onclick="popupChart('stack-start-test.txt')">Click to view Data
	       <span id="stack-start-test.txt" class="popuptext"><object width="700px" height="500px" data="log/stack-start-test.txt"></object></span>
	  </div>
	</td>
	<td align="center">
	  <div class="popup" onclick="popupChart('stressng-stat.txt')">Click to view Data
	       <span id="stressng-stat.txt" class="popuptext"><object width="700px" height="500px" data="log/stressng-stat.txt"></object></span>
	  </div>
	</td>
	<td align="center">
	  <div class="popup" onclick="popupChart('iperf-stat.txt')">Click to view Data
	       <span id="iperf-stat.txt" class="popuptext"><object width="700px" height="500px" data="log/iperf-stat.txt"></object></span>
	  </div>
	</td>
      </tr>
    </table>
    <h3 align="center">Summary</h3>
    <hr size="1" />

    <table align="center" class="details" border="0" cellpadding="5" cellspacing="2" width="95%">
      <tr valign="top">
	<th align="left">Success Rate:</th>
	<th align="left">Top 5 Worst REST API Calls Response Time 90% Line:</th>
	<th align="left">Top 5 Worst Transactions Elapsed Time 90% Line:</th>
      </tr>
      <tr>
	<td>
	  <svg height="300px" width="100%" >
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
	  <svg height="300px" width="100%">
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
	  <svg xmlns="http://www.w3.org/2000/svg" height="300px" width="100%">
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

  <h3 align="center">Openstack structure</h3>
    <hr size="1" />
    <table align="center" class="details" border="0" cellpadding="5" cellspacing="2" width="95%">
      <tr valign="top">
	<th>Node Type:</th>
	<th>Quantity:</th>
	<th>System:</th>
	<th>OS:</th>
	<th>CPU:</th>
	<th>RAM:</th>
      </tr>
      <tr valign="top">
	<td align="left">Undercloud Node</td>
	<td align="center">1</td>
	<td align="center"><xsl:value-of select="$ucSys" /></td>
	<td align="center"><xsl:value-of select="$ucOs" /></td>
	<td align="center"><xsl:value-of select="$ucCpu" /></td>
	<td align="center"><xsl:value-of select="$ucMem" /></td>
      </tr>
      <tr valign="top">
	<td align="left">Controller Node</td>
	<td align="center"><xsl:value-of select="$contrCount" /></td>
	<td align="center"><xsl:value-of select="$contrSys" /></td>
	<td align="center"><xsl:value-of select="$contrOs" /></td>
	<td align="center"><xsl:value-of select="$contrCpu" /></td>
	<td align="center"><xsl:value-of select="$contrMem" /></td>
      </tr>
      <tr valign="top">
	<td align="left">Compute Node</td>
	<td align="center"><xsl:value-of select="$compCount" /></td>
	<td align="center"><xsl:value-of select="$compSys" /></td>
	<td align="center"><xsl:value-of select="$compOs" /></td>
	<td align="center"><xsl:value-of select="$compCpu" /></td>
	<td align="center"><xsl:value-of select="$compMem" /></td>
      </tr>
      <tr valign="top">
	<td align="left">Ceph Node</td>
	<td align="center"><xsl:value-of select="$cephCount" /></td>
	<td align="center"><xsl:value-of select="$cephSys" /></td>
	<td align="center"><xsl:value-of select="$cephOs" /></td>
	<td align="center"><xsl:value-of select="$cephCpu" /></td>
	<td align="center"><xsl:value-of select="$cephMem" /></td>
      </tr>
    </table>
    <h3 align="center">Notes:</h3>
    <hr size="1" />
    <xsl:value-of select="$note" />
    <hr size="1" />
  </div>
</xsl:template>

<xsl:template name="pageFooter">
  <div class="footer" align="right">
  <a id="jmeter" href="http://jmeter.apache.org/"><img alt="JMeter" src="img/jmeter-logo.svg" height="40" width="160"></img></a>
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
