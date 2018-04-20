<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
  xmlns:math="http://exslt.org/math"
  extension-element-prefixes="math"
  xmlns:date="http://exslt.org/dates-and-times">
  
<xsl:output method="html" indent="yes" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" />

<xsl:param    name="perfmonType" select="'date not defined'"/>
<xsl:variable name="var_Monitor_Memory_Compute_Proc" select="'Monitor_Memory_Compute_Proc'" />
<xsl:variable name="var_Monitor_Memory_Compute" select="'Monitor_Memory_Compute'" />
<xsl:variable name="var_Monitor_Memory_Controller_Proc" select="'Monitor_Memory_Controller_Proc'" />
<xsl:variable name="var_Monitor_Memory_Controller" select="'Monitor_Memory_Controller'" />
<xsl:variable name="var_Monitor_Memory_Undercloud_Proc" select="'Monitor_Memory_Undercloud_Proc'" />
<xsl:variable name="var_Monitor_Memory_Undercloud" select="'Monitor_Memory_Undercloud'" />
<xsl:variable name="var_Monitor_Memory_Ceph_Proc" select="'Monitor_Memory_Ceph_Proc'" />
<xsl:variable name="var_Monitor_Memory_Ceph" select="'Monitor_Memory_Ceph'" />

<xsl:template match="testResults">
<html>
<head>
<title>Memory Utilization Report</title>
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
  <xsl:if test="$perfmonType = $var_Monitor_Memory_Undercloud">
    <xsl:call-template name="pageBody" >
      <xsl:with-param name="title-label" select="'Server Memory Utilization - Undercloud Node'" />
    </xsl:call-template>
  </xsl:if>
  <xsl:if test="$perfmonType = $var_Monitor_Memory_Undercloud_Proc">
    <xsl:call-template name="pageBody" >
      <xsl:with-param name="title-label" select="'Process Memory Utilization - Undercloud Node'" />
    </xsl:call-template>
  </xsl:if>
  <xsl:if test="$perfmonType = $var_Monitor_Memory_Controller">
    <xsl:call-template name="pageBody" >
      <xsl:with-param name="title-label" select="'Server Memory Utilization - Controller Node'" />
    </xsl:call-template>
  </xsl:if>
  <xsl:if test="$perfmonType = $var_Monitor_Memory_Controller_Proc">
    <xsl:call-template name="pageBody" >
      <xsl:with-param name="title-label" select="'Process Memory Utilization - Controller Node'" />
    </xsl:call-template>
  </xsl:if>
  <xsl:if test="$perfmonType = $var_Monitor_Memory_Compute">
    <xsl:call-template name="pageBody" >
      <xsl:with-param name="title-label" select="'Server Memory Utilization - Compute Node'" />
    </xsl:call-template>
  </xsl:if>
  <xsl:if test="$perfmonType = $var_Monitor_Memory_Compute_Proc">
    <xsl:call-template name="pageBody" >
      <xsl:with-param name="title-label" select="'Process Memory Utilization - Compute Node'" />
    </xsl:call-template>
  </xsl:if>
  <xsl:if test="$perfmonType = $var_Monitor_Memory_Ceph">
    <xsl:call-template name="pageBody" >
      <xsl:with-param name="title-label" select="'Server Memory Utilization - Ceph Node'" />
    </xsl:call-template>
  </xsl:if>
  <xsl:if test="$perfmonType = $var_Monitor_Memory_Ceph_Proc">
    <xsl:call-template name="pageBody" >
      <xsl:with-param name="title-label" select="'Process Memory Utilization - Ceph Node'" />
    </xsl:call-template>
  </xsl:if>
</body>
</html>
</xsl:template>

<xsl:template name="pageBody">
  <xsl:param name="title-label"/>

  <div class="body">
    <h3><xsl:value-of select="$title-label"/></h3>
    <hr size="1" />

    <table width="95%" cellspacing="2" cellpadding="5" border="0" class="details" align="center">
    <tr valign="top">
      <th>Click to view Chart</th>
      <th>Label</th>
      <th>Minimum</th>
      <th>Average</th>
      <th>Maximum</th>
    </tr>

    <xsl:for-each select="/testResults/kg.apc.jmeter.perfmon.PerfMonSampleResult/label[contains(.,'Memory') and not(. = preceding::*/.)]">
      <xsl:variable name="label" select="."/>
      <xsl:variable name="count" select="count(../../*[label = $label])"/>
      <xsl:variable name="totalTime" select="sum(../../*[label = $label]/elapsedTime)" />
      <xsl:variable name="minTime">
	<xsl:call-template name="min"><xsl:with-param name="nodes" select="../../*[label = $label]/elapsedTime" /></xsl:call-template>
      </xsl:variable>
      <xsl:variable name="averageTime" select="$totalTime div $count" />
      <xsl:variable name="maxTime">
	<xsl:call-template name="max"><xsl:with-param name="nodes" select="../../*[label = $label]/elapsedTime" /></xsl:call-template>
      </xsl:variable>

      <tr valign="top">
	<td align="center">
	  <div class="popup" onclick="popupChart('{$label}')"><img width="25px" height="25px" src="../img/{$label}.png" />
	    <span class="popuptext"  id="{$label}" ><img src="../img/{$label}.png" /></span>
	  </div>
	</td>
	<td align="center"><xsl:value-of select="$label"/></td>
	<td align="center"><xsl:call-template name="display-mem"><xsl:with-param name="value" select="$minTime div 1000" /></xsl:call-template></td>
	<td align="center"><xsl:call-template name="display-mem"><xsl:with-param name="value" select="$averageTime div 1000" /></xsl:call-template></td>
	<td align="center"><xsl:call-template name="display-mem"><xsl:with-param name="value" select="$maxTime div 1000" /></xsl:call-template></td>
      </tr>
    </xsl:for-each>
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

<xsl:template name="display-mem">
    <xsl:param name="value" />
    <xsl:value-of select="format-number($value,'#,###,###,### bytes')" />
</xsl:template>

</xsl:stylesheet>
