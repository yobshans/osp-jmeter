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
Openstack REST API Functional Sanity Test Report:
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
Top 5 Worst REST API Response Time:
<xsl:call-template name="maxlabel">
  <xsl:with-param name="nodes" select="httpSample" /><xsl:with-param name="pos" select="1" />
</xsl:call-template>&#160;&#x2212;&#160;<xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow1" /></xsl:call-template><xsl:text>&#xa;</xsl:text>
<xsl:call-template name="maxlabel">
  <xsl:with-param name="nodes" select="httpSample" /><xsl:with-param name="pos" select="2" />
</xsl:call-template>&#160;&#x2212;&#160;<xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow2" /></xsl:call-template><xsl:text>&#xa;</xsl:text>
<xsl:call-template name="maxlabel">
  <xsl:with-param name="nodes" select="httpSample" /><xsl:with-param name="pos" select="3" />
</xsl:call-template>&#160;&#x2212;&#160;<xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow3" /></xsl:call-template><xsl:text>&#xa;</xsl:text>
<xsl:call-template name="maxlabel">
  <xsl:with-param name="nodes" select="httpSample" /><xsl:with-param name="pos" select="4" />
</xsl:call-template>&#160;&#x2212;&#160;<xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow4" /></xsl:call-template><xsl:text>&#xa;</xsl:text>
<xsl:call-template name="maxlabel">
  <xsl:with-param name="nodes" select="httpSample" /><xsl:with-param name="pos" select="5" />
</xsl:call-template>&#160;&#x2212;&#160;<xsl:call-template name="display-time"><xsl:with-param name="value" select="$slow5" /></xsl:call-template><xsl:text>&#xa;</xsl:text>
<xsl:for-each select="httpSample[contains(@lb, '.') and not(@lb = preceding::*/@lb)]">
  <xsl:variable name="label" select="@lb" />
  <xsl:variable name="count" select="count(../*[@lb = current()/@lb])" />
  <xsl:variable name="status" select="@s" />
  <xsl:variable name="res_code" select="@rc" />
  <xsl:variable name="res_msg" select="@rm" />
  <xsl:variable name="bytes" select="@by" />
  <xsl:variable name="time" select="@t" />
  <xsl:variable name="request" select="java.net.URL" />
  <xsl:variable name="request_body" select="queryString" />
  <xsl:variable name="response" select="responseData" />
----------------------------------------------------------------------------------------------------------------
| REST APIs 			   | Status | Count | Response Code | Response Message | Bytes | Response Time | 
----------------------------------------------------------------------------------------------------------------
| <xsl:value-of select="$label" /> | <xsl:choose><xsl:when test="$status='false'">FAIL</xsl:when><xsl:otherwise>PASS</xsl:otherwise></xsl:choose>&#x9;| <xsl:value-of select="$count" />&#x9;| <xsl:value-of select="$res_code" />&#x9;| <xsl:value-of select="$res_msg" />&#x9;| <xsl:value-of select="$bytes" />&#x9;| <xsl:value-of select="$time" />&#x9;|
----------------------------------------------------------------------------------------------------------------
| HTTP Request URL: <xsl:value-of select="$request" />
| HTTP Request Body <xsl:value-of select="$request_body" />
| HTTP Response Data: <xsl:value-of select="$response" />
<xsl:text>&#xa;</xsl:text>
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
