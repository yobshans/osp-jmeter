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
<xsl:param    name="testDuration" select="'n/a'"/>
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

<xsl:template match="testResults">
<html>
<head>
<title>Openstack REST API Sanity Functional Test Report</title>
<link rel="stylesheet" href="html/result.css" type="text/css" />
<style type="text/css">
</style>
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

  <div class="topnav">
    <a class="active" href="index.html">Summary Report</a>
    <a href="html/api.html">REST API Calls Request/Response Data Report</a>
  </div>
  
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
      <xsl:with-param name="nodes" select="httpSample" /><xsl:with-param name="pos" select="1" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="slow2">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="httpSample" /><xsl:with-param name="pos" select="2" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="slow3">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="httpSample" /><xsl:with-param name="pos" select="3" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="slow4">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="httpSample" /><xsl:with-param name="pos" select="4" />
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="slow5">
    <xsl:call-template name="maxtime">
      <xsl:with-param name="nodes" select="httpSample" /><xsl:with-param name="pos" select="5" />
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="pi" select="math:constant('PI',10)" />
  <xsl:variable name="mashtab" select="$slow1 div 500" />
  <xsl:variable name="mashtabidx" select="$slow1 div 300" />
    
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
    <h3 align="center">Openstack REST API Sanity Functional Test Report</h3>
    <hr size="1" />

    <table align="center" class="details" border="0" cellpadding="5" cellspacing="2" width="95%">
      <tr valign="top">
	<th>Openstack Version:</th>
	<th>Date Report:</th>
	<th>Test Run Name:</th>
	<th>Test Duration:</th>
      </tr>
      <tr valign="top">
	<td align="center"><xsl:value-of select="$buildNum" /></td>
	<td align="center"><xsl:value-of select="$dateReport" /></td>
	<td align="center"><xsl:value-of select="$testRunName" /></td>
	<td align="center"><xsl:value-of select="$testDuration" /></td>
      </tr>
    </table>
    <h3 align="center">Summary</h3>
    <hr size="1" />

    <table align="center" class="details" border="0" cellpadding="5" cellspacing="2" width="95%">
      <tr valign="top">
	<th align="left">Success Rate:</th>
	<th align="left">Minimun, Average and Maximun Response Time:</th>
	<th align="left">Top 5 Worst REST API Response Time:</th>
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
	  <svg width="100%" height="300px" >
	    <g id="bar" transform="translate(0,300)">
	      <rect x="{position()*25}" y="-{$allMinTime  div $mashtabidx}" height="{$allMinTime*1.5}" width="50" style="fill:#00BFFF;"/><!-- deepskyblue -->
	      <text x="{position()*25 }" y="-{$allMinTime div $mashtabidx + 10}" >
		<xsl:call-template name="display-time"><xsl:with-param name="value" select="$allMinTime" /></xsl:call-template>
	      </text>
	      <rect x="{position()*125}" y="-{$allAverageTime div $mashtabidx}" height="{$allAverageTime*1.5}" width="50" style="fill:#0000FF;"/><!-- blue -->
	      <text x="{position()*125 }" y="-{$allAverageTime div $mashtabidx + 10}" >
		<xsl:call-template name="display-time"><xsl:with-param name="value" select="$allAverageTime" /></xsl:call-template>
	      </text>
	      <rect x="{position()*225}" y="-240" height="250" width="50" style="fill:#000080;"/><!-- navy -->
	      <text x="{position()*225 }" y="-250" >
		<xsl:call-template name="display-time"><xsl:with-param name="value" select="$allMaxTime" /></xsl:call-template>
	      </text>
	    </g>
	  </svg>
	</td>
	<td>
	  <svg height="300px" width="100%">
	    <g id="bar" transform="translate(0,0)">
	    <rect x="{position()*25}" y="{position()*70}" height="25" width="{$slow1 div $mashtab}" style="fill:#FF0000;"/> <!-- red -->
	    <text x="{position()*25}" y="{position()*70-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="httpSample" /><xsl:with-param name="pos" select="1" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow1" /></xsl:call-template>
	    </text>
	    <rect x="{position()*25}" y="{position()*120}" height="25" width="{$slow2 div $mashtab}" style="fill:#DC143C;"/><!-- crimson -->
	    <text x="{position()*25}" y="{position()*120-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="httpSample" /><xsl:with-param name="pos" select="2" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow2" /></xsl:call-template>
	    </text>
	    <rect x="{position()*25}" y="{position()*170}" height="25" width="{$slow3 div $mashtab}" style="fill:#DB7093;"/><!-- palevioletred -->
	    <text x="{position()*25}" y="{position()*170-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="httpSample" /><xsl:with-param name="pos" select="3" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow3" /></xsl:call-template>
	    </text>
	    <rect x="{position()*25}" y="{position()*220}" height="25" width="{$slow4 div $mashtab}" style="fill:#F08080;"/><!-- lightcoral -->
	    <text x="{position()*25}" y="{position()*220-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="httpSample" /><xsl:with-param name="pos" select="4" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow4" /></xsl:call-template>
	    </text>
	    <rect x="{position()*25}" y="{position()*270}" height="25" width="{$slow5 div $mashtab}" style="fill:#FFA07A;"/><!-- lightsalmon -->
	    <text x="{position()*25}" y="{position()*270-10}" >
	      <xsl:call-template name="maxlabel">
		<xsl:with-param name="nodes" select="httpSample" /><xsl:with-param name="pos" select="5" />
	      </xsl:call-template>&#160;&#x2212;&#160;
	      <xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow5" /></xsl:call-template>
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
      <xsl:sort select = "@t" data-type="number" order="descending" />
	<xsl:if test="position() = $pos">
	  <xsl:value-of select="@lb" />
	</xsl:if>
    </xsl:for-each>
</xsl:template>

<xsl:template name="maxtime">
  <xsl:param name="nodes" select="/.." />
  <xsl:param name="pos" />
    <xsl:for-each select="$nodes">
      <xsl:sort select = "@t" data-type="number" order="descending" />
	<xsl:if test="position() = $pos">
	  <xsl:value-of select="@t" />
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
