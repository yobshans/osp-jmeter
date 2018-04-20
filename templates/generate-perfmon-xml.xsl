<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1">
<xsl:output method="xml" indent="yes" encoding="UTF-8" />

<!-- Defined parameters (overrideable) -->
<xsl:param    name="showData" select="'n'"/>

<xsl:template name="xmllist" match="/">
	<!-- CPU -->
	<xsl:text>&#xa;</xsl:text>
	<xsl:element name="test">
	<xsl:for-each select="/testResults/kg.apc.jmeter.perfmon.PerfMonSampleResult/label[contains(.,'CPU') and not(. = preceding::*/.)]">
		<xsl:variable name="label" select="."/>
		<xsl:variable name="count" select="count(../../*[label = $label])"/>
		<xsl:variable name="totalTime" select="sum(../../*[label = $label]/elapsedTime)" />
		<xsl:variable name="host" select="substring-before($label,'CPU')"/>
		<xsl:variable name="minTime">
			<xsl:call-template name="min">
				<xsl:with-param name="nodes" select="../../*[label = $label]/elapsedTime" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="averageTime" select="$totalTime div $count" />
		<xsl:variable name="maxTime">
			<xsl:call-template name="max">
				<xsl:with-param name="nodes" select="../../*[label = $label]/elapsedTime" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:text>&#xa;</xsl:text>
		<xsl:element name="cpu">
			<xsl:attribute name="label"><xsl:value-of select="substring(substring-after($label,$host),1)"/></xsl:attribute>
			<xsl:attribute name="min"><xsl:value-of select="$minTime div 100000"/></xsl:attribute>
			<xsl:attribute name="ave"><xsl:value-of select="$averageTime div 100000"/></xsl:attribute>
			<xsl:attribute name="max"><xsl:value-of select="$maxTime div 100000"/></xsl:attribute>
		</xsl:element>
	</xsl:for-each>
	<!-- Memory -->
	<xsl:for-each select="/testResults/kg.apc.jmeter.perfmon.PerfMonSampleResult/label[contains(.,'Memory') and not(. = preceding::*/.)]">
		<xsl:variable name="label" select="."/>
		<xsl:variable name="count" select="count(../../*[label = $label])"/>
		<xsl:variable name="totalTime" select="sum(../../*[label = $label]/elapsedTime)" />
		<xsl:variable name="host" select="substring-before($label,'Memory')"/>
		<xsl:variable name="minTime">
			<xsl:call-template name="min">
				<xsl:with-param name="nodes" select="../../*[label = $label]/elapsedTime" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="averageTime" select="$totalTime div $count" />
		<xsl:variable name="maxTime">
			<xsl:call-template name="max">
				<xsl:with-param name="nodes" select="../../*[label = $label]/elapsedTime" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:text>&#xa;</xsl:text>
		<xsl:element name="cpu">
			<xsl:attribute name="label"><xsl:value-of select="substring(substring-after($label,$host),1)"/></xsl:attribute>
			<xsl:attribute name="min"><xsl:value-of select="$minTime div 1000"/></xsl:attribute>
			<xsl:attribute name="ave"><xsl:value-of select="$averageTime div 1000"/></xsl:attribute>
			<xsl:attribute name="max"><xsl:value-of select="$maxTime div 1000"/></xsl:attribute>
		</xsl:element>
	</xsl:for-each>
	<!-- Disk -->
	<xsl:for-each select="/testResults/kg.apc.jmeter.perfmon.PerfMonSampleResult/label[contains(.,'Disk') and not(. = preceding::*/.)]">
		<xsl:variable name="label" select="."/>
		<xsl:variable name="count" select="count(../../*[label = $label])"/>
		<xsl:variable name="totalTime" select="sum(../../*[label = $label]/elapsedTime)" />
		<xsl:variable name="host" select="substring-before($label,'Disk')"/>
		<xsl:variable name="minTime">
			<xsl:call-template name="min">
				<xsl:with-param name="nodes" select="../../*[label = $label]/elapsedTime" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="averageTime" select="$totalTime div $count" />
		<xsl:variable name="maxTime">
			<xsl:call-template name="max">
				<xsl:with-param name="nodes" select="../../*[label = $label]/elapsedTime" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:text>&#xa;</xsl:text>
		<xsl:element name="cpu">
			<xsl:attribute name="label"><xsl:value-of select="substring(substring-after($label,$host),1)"/></xsl:attribute>
			<xsl:attribute name="min"><xsl:value-of select="$minTime div 1000"/></xsl:attribute>
			<xsl:attribute name="ave"><xsl:value-of select="$averageTime div 1000"/></xsl:attribute>
			<xsl:attribute name="max"><xsl:value-of select="$maxTime div 1000"/></xsl:attribute>
		</xsl:element>
	</xsl:for-each>
	<!-- Network -->
	<xsl:for-each select="/testResults/kg.apc.jmeter.perfmon.PerfMonSampleResult/label[contains(.,'Network') and not(. = preceding::*/.)]">
		<xsl:variable name="label" select="."/>
		<xsl:variable name="count" select="count(../../*[label = $label])"/>
		<xsl:variable name="totalTime" select="sum(../../*[label = $label]/elapsedTime)" />
		<xsl:variable name="host" select="substring-before($label,'Network')"/>
		<xsl:variable name="minTime">
			<xsl:call-template name="min">
				<xsl:with-param name="nodes" select="../../*[label = $label]/elapsedTime" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="averageTime" select="$totalTime div $count" />
		<xsl:variable name="maxTime">
			<xsl:call-template name="max">
				<xsl:with-param name="nodes" select="../../*[label = $label]/elapsedTime" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:text>&#xa;</xsl:text>
		<xsl:element name="cpu">
			<xsl:attribute name="label"><xsl:value-of select="substring(substring-after($label,$host),1)"/></xsl:attribute>
			<xsl:attribute name="min"><xsl:value-of select="$minTime div 1000"/></xsl:attribute>
			<xsl:attribute name="ave"><xsl:value-of select="$averageTime div 1000"/></xsl:attribute>
			<xsl:attribute name="max"><xsl:value-of select="$maxTime div 1000"/></xsl:attribute>
		</xsl:element>
	</xsl:for-each>
	</xsl:element>
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

<xsl:template name="display-number">
	<xsl:param name="value" />
	<xsl:value-of select="format-number($value,'0.00')" />
</xsl:template>

</xsl:stylesheet>
