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
<xsl:variable name="percent-fail-factor" select="0.1" />

<xsl:template match="testResults">
<html>
<head>
<title>Openstack HTTP Request/Response Detailed Report</title>
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

  <div class="topnav">
    <a href="../index.html">Summary Report</a>
    <a class="active" href="api.html">HTTP Request/Response Data Report</a>
  </div>
  
</xsl:template>

<xsl:template name="pageBody">

  <div class="body">
    <h3 align="center">Openstack HTTP Request/Response Detailed Report</h3>
    <hr size="1" />

    <table width="95%" cellspacing="2" cellpadding="5" border="0" class="details" align="center">
    <tr valign="top">
      <th>Request and Response Data</th>
      <th>HTTP Requests</th>
      <th>Status</th>
      <th>Count</th>
      <th>Response Code</th>
      <th>Response Message</th>
      <th>Bytes</th>
      <th>Response Time</th>
    </tr>

    <xsl:for-each select="sample[contains(@lb, '.') and not(contains(@lb, 'Trx')) and not(@lb = preceding::*/@lb)]">
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
      

      <tr valign="top">
	<xsl:attribute name="class">
	  <xsl:choose>
	    <xsl:when test="$status='false'">Failure</xsl:when>
	  </xsl:choose>
	</xsl:attribute>
	<td align="center"></td>
	<td align="left"><xsl:value-of select="$label" /></td>
        <xsl:choose>
          <xsl:when test="$status='false'">
            <td align="center">FAIL</td>
	  </xsl:when>
 	  <xsl:otherwise>
             <td align="center">PASS</td>
          </xsl:otherwise>
	</xsl:choose>
	<td align="center"><xsl:value-of select="$count" /></td>
	<td align="center"><xsl:value-of select="$res_code" /></td>
	<td align="center"><xsl:value-of select="$res_msg" /></td>
	<td align="center"><xsl:value-of select="$bytes" /></td>
	<td align="center"><xsl:value-of select="$time" /></td>
      </tr>
      <xsl:for-each select="httpSample">
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
	

	<tr valign="top">
	  <xsl:attribute name="class">
	    <xsl:choose>
	      <xsl:when test="$status='false'">Failure</xsl:when>
	    </xsl:choose>
	  </xsl:attribute>
	  <td align="center">
	    <div class="popup" onclick="popupChart('{$label}')">Click to view Data
	      <span class="popuptext"  id="{$label}" bgcolor="#f2f2f2" style="overflow-y:scroll; height:600px;">
		<table bordercolor="#000000" bgcolor="#f2f2f2" border="1"  cellpadding="1" cellspacing="1" style="width:100%">
		  <tr>
		    <th>HTTP</th>
		    <th>Data</th>
		  </tr>
		  <tr>
		    <td width="10%" align="left">Request URL: </td>
		    <td width="90%" align="left"><xsl:value-of select="$request" /></td>
		  </tr>
		  <tr>
		    <td width="10%" align="left">Request Body: </td>
		    <td width="90%" align="left"><xsl:value-of select="$request_body" /></td>
		  </tr>
		  <tr>
		    <td width="10%" align="left">Response: </td>
		    <td width="90%" align="left"><xsl:value-of select="$response" /></td>
		  </tr>
		</table>
	      </span>
	    </div>
	  </td>
	  <td align="left"><xsl:value-of select="$label" /></td>
          <xsl:choose>
	    <xsl:when test="$status='false'">
               <td align="center">FAIL</td>
	    </xsl:when>
 	    <xsl:otherwise>
               <td align="center">PASS</td>
            </xsl:otherwise>
	  </xsl:choose>
	  <td align="center"><xsl:value-of select="$count" /></td>
	  <td align="center"><xsl:value-of select="$res_code" /></td>
	  <td align="center"><xsl:value-of select="$res_msg" /></td>
	  <td align="center"><xsl:value-of select="$bytes" /></td>
	  <td align="center"><xsl:value-of select="$time" /></td>
	</tr>
      </xsl:for-each>
      <tr>	
	  <td> </td>
	  <td> </td>
      </tr>
      <tr>	
	  <td> </td>
	  <td> </td>
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
	<xsl:value-of select="format-number($value,'0 ms')" />
</xsl:template>
	
</xsl:stylesheet>
