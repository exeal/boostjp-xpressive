<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>
  <xsl:import href="/usr/local/opt/docbook-xsl/docbook-xsl/xhtml5/chunk.xsl"/>

  <!-- 1.7. HTML -->
  <xsl:param name="html.stylesheet">../../resource/boostjp.css ../../resource/fundamental/.css</xsl:param>
  <xsl:param name="make.clean.html" select="1"/>

  <!-- 1.8. XSLT Processing -->
  <xsl:param name="suppress.header.navigation"/>

  <!-- 1.10. Reference Pages -->
  <xsl:param name="refentry.generate.title"/>

  <!-- 1.17. Glossary -->
  <xsl:param name="glossterm.auto.link" select="1"/>

  <!-- 1.21. Chunking -->
  <xsl:param name="chunker.output.indent">yes</xsl:param>
  <xsl:param name="root.filename">index</xsl:param>
  <xsl:param name="use.id.as.filename">1</xsl:param>
</xsl:stylesheet>
