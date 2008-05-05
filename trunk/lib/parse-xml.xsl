#!/usr/bin/xsltproc
<xsl:stylesheet version = '1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

<xsl:template match="*">
  <xsl:value-of select="name()" /> <xsl:if test="@value = ''"><xsl:value-of select="@value" /></xsl:if><xsl:text> {</xsl:text>
  <xsl:for-each select="@*">
    <xsl:text>jd:meta:</xsl:text><xsl:value-of select="name()" /> <xsl:value-of select="." />
  </xsl:for-each>
  <xsl:apply-templates />
  <xsl:text>}
</xsl:text>
</xsl:template>


<xsl:template match="problem">
  <xsl:value-of select="name()" />








<xsl:template match="run-limits">
  <xsl:template match="time">
  <xsl:template match="memory">
  <xsl:template match="process">
  <xsl:template match="cpu-mask">
  <xsl:template match="priority">
  <xsl:template match="user">
  <xsl:template match="score">
</xsl:template>

<xsl:template match="file">
  <xsl:template match="type" comment="文件类型：file/text/fd/search/command">
  <xsl:template match=".|value|@value|name|@name" comment="url/stdin/stdout/text">
  <xsl:template match="mime">
  <xsl:template match="file-search">
  <xsl:template match="accept">
  <xsl:template match="result">
    <xsl:template match="success">
  <xsl:template match="virtual" comment="用ln复制">
  <xsl:template match="run-time" comment="运行时复制">
  <xsl:template match="force-override" comment="强制覆盖">
  <xsl:template match="clean" comment="自动删除，以及删除命令">
</xsl:template>


<xsl:template match="file-search">
</xsl:template>


<xsl:template match="excute">
</xsl:template>

<xsl:template match="eval">
</xsl:template>
