<!--
   Xsl file for translating Cena config to Lowsars config.
   This should be used together with lowsars-cena.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">
<xsl:for-each select="cena/contest">
	<xsl:for-each select="problem">
	problem <xsl:value-of select="@filename"/>
		<xsl:if test="@comparetype=1">
		judge ignore emptyline white</xsl:if>
		<xsl:if test="@comparetype=0">
		judge ignore nothing</xsl:if>
		<xsl:if test="@comparetype=2">
		<xsl:message terminate="yes">
Sorry, Lowsars 0.2 does not support Special Judge from Cena file.
		</xsl:message>
		</xsl:if>
		<!--TODO what's the parameter of that? Should look at Cena's help.
		Also, what about wine it? -->
		input <xsl:value-of select="input/@filename"/><!--
		TODO how is multiple input files arranged here??
		-->
		output <xsl:value-of select="output/@filename"/>
		<xsl:for-each select="testcase">
		case <xsl:number value="position()" />
			input <xsl:value-of select="input/@filename"/>
			output <xsl:value-of select="output/@filename"/>
			timelimit <xsl:value-of select="@timelimit"/>
			memory <xsl:value-of select="@memorylimit"/>
			score <xsl:value-of select="@score"/>
		</xsl:for-each>
	</xsl:for-each>
</xsl:for-each>
end
</xsl:template>
</xsl:stylesheet>

