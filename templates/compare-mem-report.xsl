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
<xsl:param    name="perfmonType" select="'date not defined'"/>
<xsl:variable name="var_Monitor_Memory_Compute_Proc" select="'Monitor_Memory_Compute_Proc'" />
<xsl:variable name="var_Monitor_Memory_Compute" select="'Monitor_Memory_Compute'" />
<xsl:variable name="var_Monitor_Memory_Controller_Proc" select="'Monitor_Memory_Controller_Proc'" />
<xsl:variable name="var_Monitor_Memory_Controller" select="'Monitor_Memory_Controller'" />
<xsl:variable name="var_Monitor_Memory_Undercloud_Proc" select="'Monitor_Memory_Undercloud_Proc'" />
<xsl:variable name="var_Monitor_Memory_Undercloud" select="'Monitor_Memory_Undercloud'" />
<xsl:variable name="var_Monitor_Memory_Ceph_Proc" select="'Monitor_Memory_Ceph_Proc'" />
<xsl:variable name="var_Monitor_Memory_Ceph" select="'Monitor_Memory_Ceph'" />
<xsl:variable name="percent-fail-factor" select="1000" />
<xsl:variable name="file2" select="document($testRes2)" />

<xsl:template match="test">
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
    <h3 align="center"><xsl:value-of align="center" select="$title-label"/></h3>
    <hr size="1" />

    <table align="center" class="details" border="0" cellpadding="5" cellspacing="2" width="95%">
      <tr valign="top">
	<th>Click to view Chart</th>
	<th>Label</th>
	<th>Baseline Test (Min)</th>
	<th>Current Test (Min)</th>
	<th>Difference (Min)</th>
	<th>Baseline Test (Average)</th>
	<th>Current Test (Average)</th>
	<th>Difference (Average)</th>
	<th>Baseline Test (Max)</th>
	<th>Current Test (Max)</th>
	<th>Difference (Max)</th>
      </tr>
      <xsl:for-each select="/test/cpu[contains(@label, 'Memory') and not(@label = preceding::*/@label)]">
	<xsl:variable name="label" select="@label" />
	<xsl:variable name="host" select="substring-before($label,'Memory')"/>
	<xsl:variable name="label1" select="substring(substring-after($label,$host),1)"/>
	<xsl:variable name="minCur" select="@min" />
	<xsl:variable name="minBase" select="$file2/test/cpu/../*[@label = current()/@label]/@min"/>
	<xsl:variable name="diff-min" select="$minCur - $minBase" />
	<xsl:variable name="aveCur" select="@ave" />
	<xsl:variable name="aveBase" select="$file2/test/cpu/../*[@label = current()/@label]/@ave"/>
	<xsl:variable name="diff-ave" select="$aveCur - $aveBase" />
	<xsl:variable name="maxCur" select="@max" />
	<xsl:variable name="maxBase" select="$file2/test/cpu/../*[@label = current()/@label]/@max"/>
	<xsl:variable name="diff-max" select="$maxCur - $maxBase" />
	<xsl:variable name="diff-perc" select="((($aveCur - $aveBase) * 100) div $aveBase) div 100" />
	<xsl:variable name="trans-label" select="translate($label1,' ','')"/>

	<tr valign="top">
	  <xsl:attribute name="class">
	    <xsl:if test="$diff-ave &gt; $percent-fail-factor">Failure</xsl:if>
	    <xsl:if test="$diff-ave &lt; 0 - $percent-fail-factor">Passed</xsl:if>
	  </xsl:attribute>
	  <td align="center">
	    <div class="popup" onclick="popupChart('{$trans-label}')"><img width="25px" height="25px" src="../img/{$label1}-mrg.png" />
	      <span class="popuptext"  id="{$trans-label}" ><img src="../img/{$label1}-mrg.png" /></span>
	    </div>
	  </td>
	  <td align="left"><xsl:value-of select="$label1" /></td>
	  <td align="center"><xsl:call-template name="display-mem"><xsl:with-param name="value" select="$minBase" /></xsl:call-template></td>
	  <td align="center"><xsl:call-template name="display-mem"><xsl:with-param name="value" select="$minCur" /></xsl:call-template></td>
	  <td align="center"><xsl:call-template name="display-mem"><xsl:with-param name="value" select="$diff-min" /></xsl:call-template></td>
	  <td align="center"><xsl:call-template name="display-mem"><xsl:with-param name="value" select="$aveBase" /></xsl:call-template></td>
	  <td align="center"><xsl:call-template name="display-mem"><xsl:with-param name="value" select="$aveCur" /></xsl:call-template></td>
	  <td align="center"><xsl:call-template name="display-mem"><xsl:with-param name="value" select="$diff-ave" /></xsl:call-template></td>
	  <td align="center"><xsl:call-template name="display-mem"><xsl:with-param name="value" select="$maxBase" /></xsl:call-template></td>
	  <td align="center"><xsl:call-template name="display-mem"><xsl:with-param name="value" select="$maxCur" /></xsl:call-template></td>
	  <td align="center"><xsl:call-template name="display-mem"><xsl:with-param name="value" select="$diff-max" /></xsl:call-template></td>
	</tr>
      </xsl:for-each>
    </table>
  </div>

</xsl:template>

<xsl:template name="display-mem">
    <xsl:param name="value" />
    <xsl:value-of select="format-number($value,'#,###,###,### bytes')" />
</xsl:template>

</xsl:stylesheet>