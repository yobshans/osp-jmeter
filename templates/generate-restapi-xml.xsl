<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1">
<xsl:output method="xml" indent="yes" encoding="UTF-8" />

<!-- Defined parameters (overrideable) -->
<xsl:param    name="showData" select="'n'"/>

<xsl:template name="keystonepagelist" match="/">
	<!-- KEYSTONE -->
	<xsl:text>&#xa;</xsl:text>
	<xsl:element name="test">
	<xsl:for-each select="/testResults/httpSample[contains(@lb, 'KEYSTONE') and not(@lb = preceding::*/@lb)]">
		<xsl:variable name="lbl" select="@lb" />
		<xsl:variable name="percent">
			<xsl:call-template name="percentiles">
				<xsl:with-param name="nodes" select="../*[@lb = current()/@lb]/@t" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:text>&#xa;</xsl:text>
		<xsl:element name="trx">
			<xsl:attribute name="label"><xsl:value-of select="$lbl"/></xsl:attribute>
			<xsl:attribute name="perc"><xsl:value-of select ="$percent"/></xsl:attribute>
		<xsl:apply-templates />
		</xsl:element>
	</xsl:for-each>
	<!-- NOVA -->
	<xsl:for-each select="/testResults/httpSample[contains(@lb, 'NOVA') and not(@lb = preceding::*/@lb)]">
		<xsl:variable name="lbl" select="@lb" />
		<xsl:variable name="percent">
			<xsl:call-template name="percentiles">
				<xsl:with-param name="nodes" select="../*[@lb = current()/@lb]/@t" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:text>&#xa;</xsl:text>
		<xsl:element name="trx">
			<xsl:attribute name="label"><xsl:value-of select="$lbl"/></xsl:attribute>
			<xsl:attribute name="perc"><xsl:value-of select ="$percent"/></xsl:attribute>
		<xsl:apply-templates />
		</xsl:element>
	</xsl:for-each>
	<!-- NEUTRON -->
	<xsl:for-each select="/testResults/httpSample[contains(@lb, 'NEUTRON') and not(@lb = preceding::*/@lb)]">
		<xsl:variable name="lbl" select="@lb" />
		<xsl:variable name="percent">
			<xsl:call-template name="percentiles">
				<xsl:with-param name="nodes" select="../*[@lb = current()/@lb]/@t" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:text>&#xa;</xsl:text>
		<xsl:element name="trx">
			<xsl:attribute name="label"><xsl:value-of select="$lbl"/></xsl:attribute>
			<xsl:attribute name="perc"><xsl:value-of select ="$percent"/></xsl:attribute>
		<xsl:apply-templates />
		</xsl:element>
	</xsl:for-each>
	<!-- NEUTRON -->
	<xsl:for-each select="/testResults/httpSample[contains(@lb, 'CINDER') and not(@lb = preceding::*/@lb)]">
		<xsl:variable name="lbl" select="@lb" />
		<xsl:variable name="percent">
			<xsl:call-template name="percentiles">
				<xsl:with-param name="nodes" select="../*[@lb = current()/@lb]/@t" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:text>&#xa;</xsl:text>
		<xsl:element name="trx">
			<xsl:attribute name="label"><xsl:value-of select="$lbl"/></xsl:attribute>
			<xsl:attribute name="perc"><xsl:value-of select ="$percent"/></xsl:attribute>
		<xsl:apply-templates />
		</xsl:element>
	</xsl:for-each>
	<!-- GLANCE -->
	<xsl:for-each select="/testResults/httpSample[contains(@lb, 'GLANCE') and not(@lb = preceding::*/@lb)]">
		<xsl:variable name="lbl" select="@lb" />
		<xsl:variable name="percent">
			<xsl:call-template name="percentiles">
				<xsl:with-param name="nodes" select="../*[@lb = current()/@lb]/@t" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:text>&#xa;</xsl:text>
		<xsl:element name="trx">
			<xsl:attribute name="label"><xsl:value-of select="$lbl"/></xsl:attribute>
			<xsl:attribute name="perc"><xsl:value-of select ="$percent"/></xsl:attribute>
		<xsl:apply-templates />
		</xsl:element>
	</xsl:for-each>
	<!-- Trx -->
	<xsl:for-each select="/testResults/sample[contains(@lb, 'Trx') and not(@lb = preceding::*/@lb)]">
		<xsl:variable name="lbl" select="@lb" />
		<xsl:variable name="percent">
			<xsl:call-template name="percentiles">
				<xsl:with-param name="nodes" select="../*[@lb = current()/@lb]/@t" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:text>&#xa;</xsl:text>
		<xsl:element name="trx">
			<xsl:attribute name="label"><xsl:value-of select="$lbl"/></xsl:attribute>
			<xsl:attribute name="perc"><xsl:value-of select ="$percent"/></xsl:attribute>
		<xsl:apply-templates />
		</xsl:element>
	</xsl:for-each>
	</xsl:element>
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

</xsl:stylesheet>
