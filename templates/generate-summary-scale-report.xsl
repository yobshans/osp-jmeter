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
<xsl:param    name="numVM" select="'n/a'"/>
<xsl:param    name="numNet" select="'n/a'"/>
<xsl:param    name="underSystem" select="'n/a'"/>
<xsl:param    name="underOS" select="'n/a'"/>
<xsl:param    name="underCPU" select="'n/a'"/>
<xsl:param    name="underMem" select="'n/a'"/>
<xsl:param    name="perfMon" select="'n/a'"/>
<xsl:variable name="percent-fail-factor" select="0.1" />
<xsl:variable name="file2" select="document($testRes2)" />

<xsl:template match="testResults">
<html>
<head>
<title>RHOS REST API Scale Test Report</title>
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
  <div align="left" class="header">
    <a  href="https://www.redhat.com/en/technologies/linux-platforms/openstack-platform" id="redhat">
	<img src="img/RHOSP-Header-Logo.png" alt="Red Hat Openstack" />
    </a>
  </div>

  <xsl:if test="$perfMon = 'True'">
    <div class="topnav">
      <a class="active" href="index.html">Summary</a>
      <a href="html/api.html">REST API</a>
      <a href="html/trx.html">Transactions</a>
      <a href="html/cpu.html">CPU</a>
      <a href="html/mem.html">Memory</a>
      <a href="html/net.html">Network</a>
      <a href="html/disk.html">Disk</a>
    </div>
  </xsl:if>
  <xsl:if test="$perfMon = 'False'">
    <div class="topnav">
      <a class="active" href="index.html">Summary</a>
      <a href="html/api.html">REST API</a>
      <a href="html/trx.html">Transactions</a>
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
      <xsl:with-param name="nodes" select="$file2/test/trx" /><xsl:with-param name="pos" select="1" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="slow2">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="$file2/test/trx" /><xsl:with-param name="pos" select="2" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="slow3">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="$file2/test/trx" /><xsl:with-param name="pos" select="3" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="slow4">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="$file2/test/trx" /><xsl:with-param name="pos" select="4" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="slow5">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="$file2/test/trx" /><xsl:with-param name="pos" select="5" />
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="pi" select="math:constant('PI',10)" />
  <xsl:variable name="mashtab" select="$slow1 div 500" />
    
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
    <h3>RHOS REST API Scale Test Report</h3>
    <hr size="1" />

    <table align="center" class="details" border="0" cellpadding="5" cellspacing="2" width="95%">
      <tr valign="top">
	<th>Openstack Version:</th>
	<th>Date Report:</th>
	<th>Test Run Name:</th>
	<th>Test Duration:</th>
	<th>Tenants Number:</th>
	<th>Networks per Tenant:</th>
	<th>Instances per Network:</th>
      </tr>
      <tr valign="top">
	<td align="center"><xsl:value-of select="$buildNum" /></td>
	<td align="center"><xsl:value-of select="$dateReport" /></td>
	<td align="center"><xsl:value-of select="$testRunName" /></td>
	<td align="center"><xsl:value-of select="$testDuration" /></td>
	<td align="center"><xsl:value-of select="$numThreads" /></td>
	<td align="center"><xsl:value-of select="$numNet" /></td>
	<td align="center"><xsl:value-of select="$numVM" /></td>
      </tr>
    </table>
    <h3>Summary</h3>
    <hr size="1" />

    <table align="center" class="details" border="0" cellpadding="5" cellspacing="2" width="95%">
      <tr valign="top">
	<th align="left">Success Rate:</th>
	<th align="left">Top 5 Worst REST API Calls Response Time 90% Line:</th>
	<th align="left">Boot Instances Rate:</th>
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
		<xsl:with-param name="nodes" select="$file2/test/trx" /><xsl:with-param name="pos" select="1" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow1" /></xsl:call-template>
	    </text>
	    <rect x="{position()*25}" y="{position()*120}" height="25" width="{$slow2 div $mashtab}" style="fill:#DC143C;"/><!-- crimson -->
	    <text x="{position()*25}" y="{position()*120-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="$file2/test/trx" /><xsl:with-param name="pos" select="2" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow2" /></xsl:call-template>
	    </text>
	    <rect x="{position()*25}" y="{position()*170}" height="25" width="{$slow3 div $mashtab}" style="fill:#DB7093;"/><!-- palevioletred -->
	    <text x="{position()*25}" y="{position()*170-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="$file2/test/trx" /><xsl:with-param name="pos" select="3" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow3" /></xsl:call-template>
	    </text>
	    <rect x="{position()*25}" y="{position()*220}" height="25" width="{$slow4 div $mashtab}" style="fill:#F08080;"/><!-- lightcoral -->
	    <text x="{position()*25}" y="{position()*220-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="$file2/test/trx" /><xsl:with-param name="pos" select="4" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow4" /></xsl:call-template>
	    </text>
	    <rect x="{position()*25}" y="{position()*270}" height="25" width="{$slow5 div $mashtab}" style="fill:#FFA07A;"/><!-- lightsalmon -->
	    <text x="{position()*25}" y="{position()*270-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="$file2/test/trx" /><xsl:with-param name="pos" select="5" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow5" /></xsl:call-template>
	    </text>
	  </g>
	</svg>
      </td>
      <td>
	<div class="popup" onclick="popupChart('TPS.03.NOVA.POST.Boot.Server.Trx')"><img width="400px" height="300px" src="img/TPS.03.NOVA.POST.Boot.Server.Trx.png" />
	  <span class="popuptext"  id="TPS.03.NOVA.POST.Boot.Server.Trx" ><img src="img/TPS.03.NOVA.POST.Boot.Server.Trx.png" /></span>
	</div>
	<!--table width="95%" cellspacing="2" cellpadding="5" border="0" class="details" align="center">
	  <tr valign="top">
	    <th>Click to view Chart</th>
	    <th>Transactions</th>
	  </tr>
	  <xsl:for-each select="sample[contains(@lb, '03.NOVA.POST.Boot.Server.Trx')]">
	    <xsl:variable name="timeStamp" select="@ts" />
	    <xsl:variable name="count" select="position()" />
	    <xsl:variable name="counter" select="0" />
	    <xsl:if test="$counter = 10">
	      <tr valign="top">
		<td align="left"><xsl:value-of select="$timeStamp" /></td>
		<td align="center"><xsl:value-of select="$count" /></td>
	      </tr>
	      <xsl:variable name="counter" select="0" />
	    </xsl:if>
	    <xsl:if test="$counter &lt; 10">
	      <xsl:variable name="counter" select="$counter + 1" />
	    </xsl:if>
	</xsl:for-each>
	</table-->
      </td>
    </tr>
  </table>

  <h3>Stack structure</h3>
    <hr size="1" />
    <table align="center" class="details" border="0" cellpadding="5" cellspacing="2" width="95%">
      <tr valign="top">
	<th>Node type:</th>
	<th>Amount:</th>
	<th>System:</th>
	<th>OS:</th>
	<th>CPU:</th>
	<th>RAM:</th>
      </tr>
      <tr valign="top">
	<td align="left">Undercloud</td>
	<td align="center">1</td>
	<td align="center"><xsl:value-of select="$underSystem" /></td>
	<td align="center"><xsl:value-of select="$underOS" /></td>
	<td align="center"><xsl:value-of select="$underCPU" /></td>
	<td align="center"><xsl:value-of select="$underMem" /></td>
      </tr>
      <tr valign="top">
	<td align="left">Controller</td>
	<td align="center">3</td>
	<td align="center"><xsl:value-of select="$underSystem" /></td>
	<td align="center"><xsl:value-of select="$underOS" /></td>
	<td align="center"><xsl:value-of select="$underCPU" /></td>
	<td align="center"><xsl:value-of select="$underMem" /></td>
      </tr>
      <tr valign="top">
	<td align="left">Compute</td>
	<td align="center">6</td>
	<td align="center"><xsl:value-of select="$underSystem" /></td>
	<td align="center"><xsl:value-of select="$underOS" /></td>
	<td align="center"><xsl:value-of select="$underCPU" /></td>
	<td align="center"><xsl:value-of select="$underMem" /></td>
      </tr>
    </table>
  </div>
</xsl:template>

<xsl:template name="pageFooter">
  <div align="right" class="footer">
    <a href="http://www.redhat.com/" id="redhat">
	<img src="img/logo.svg" alt="Red Hat" />
    </a>
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
	<xsl:value-of select="format-number($value,'0 ms')" />
</xsl:template>
	
<xsl:template name="display-image">
	<xsl:param name="suffix" />
	<xsl:element name="img">
		<xsl:attribute name="src">img/<xsl:value-of select="$suffix" />.png</xsl:attribute>
	</xsl:element>
</xsl:template>
</xsl:stylesheet>
