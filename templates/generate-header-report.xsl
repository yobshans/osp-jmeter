<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
  xmlns:math="http://exslt.org/math"
  extension-element-prefixes="math"
  xmlns:date="http://exslt.org/dates-and-times">
  
<xsl:output method="html" indent="yes" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" />

<xsl:param    name="activeTab" select="'date not defined'"/>
<xsl:param    name="tabName" expression="'date not defined'"/>
<xsl:variable name="var_CPU_Tab" select="'CPU'" />
<xsl:variable name="var_Mem_Tab" select="'Mem'" />
<xsl:variable name="var_Net_Tab" select="'Net'" />
<xsl:variable name="var_Disk_Tab" select="'Disk'" />

<xsl:template match="testResults">
<html>
<head>
  <xsl:if test="$activeTab = $var_CPU_Tab">
    <title>CPU Utilization Report</title>
  </xsl:if>
  <xsl:if test="$activeTab = $var_Mem_Tab">
    <title>Memory Utilization Report</title>
  </xsl:if>
  <xsl:if test="$activeTab = $var_Net_Tab">
    <title>Network Utilization Report</title>
  </xsl:if>
  <xsl:if test="$activeTab = $var_Disk_Tab">
    <title>Disk Utilization Report</title>
  </xsl:if>
<link rel="stylesheet" href="../html/result.css" type="text/css" />
<style type="text/css">
</style>
</head>
<body>
  <xsl:call-template name="pageHeader" />
</body>
</html>
</xsl:template>

<xsl:template name="pageHeader">
  <div class="header" align="center">
  <a id="openstack" href="https://www.openstack.org/"><img alt="Openstack" src="../img/openstack-logo.svg" height="50" width="200"></img></a>
  </div>

  <xsl:if test="$activeTab = $var_CPU_Tab">
    <div class="topnav">
      <a href="../index.html">Summary Report</a>
      <a href="api.html"><xsl:value-of select="$tabName" /></a>
      <a href="trx.html">Transactions Elapsed Time Report</a>
      <a class="active"  href="cpu.html">CPU Utilization Report</a>
      <a href="mem.html">Memory Utilization Report</a>
      <a href="net.html">Network Utilization Report</a>
      <a href="disk.html">Disk Utilization Report</a>
    </div>
  </xsl:if>
  <xsl:if test="$activeTab = $var_Mem_Tab">
    <div class="topnav">
      <a href="../index.html">Summary Report</a>
      <a href="api.html"><xsl:value-of select="$tabName" /></a>
      <a href="trx.html">Transactions Elapsed Time Report</a>
      <a href="cpu.html">CPU Utilization Report</a>
      <a class="active" href="mem.html">Memory Utilization Report</a>
      <a href="net.html">Network Utilization Report</a>
      <a href="disk.html">Disk Utilization Report</a>
    </div>
  </xsl:if>
  <xsl:if test="$activeTab = $var_Net_Tab">
    <div class="topnav">
      <a href="../index.html">Summary Report</a>
      <a href="api.html"><xsl:value-of select="$tabName" /></a>
      <a href="trx.html">Transactions Elapsed Time Report</a>
      <a href="cpu.html">CPU Utilization Report</a>
      <a href="mem.html">Memory Utilization Report</a>
      <a class="active" href="net.html">Network Utilization Report</a>
      <a href="disk.html">Disk Utilization Report</a>
    </div>
  </xsl:if>
  <xsl:if test="$activeTab = $var_Disk_Tab">
    <div class="topnav">
      <a href="../index.html">Summary Report</a>
      <a href="api.html"><xsl:value-of select="$tabName" /></a>
      <a href="trx.html">Transactions Elapsed Time Report</a>
      <a href="cpu.html">CPU Utilization Report</a>
      <a href="mem.html">Memory Utilization Report</a>
      <a href="net.html">Network Utilization Report</a>
      <a class="active" href="disk.html">Disk Utilization Report</a>
    </div>
  </xsl:if>

</xsl:template>

</xsl:stylesheet>
