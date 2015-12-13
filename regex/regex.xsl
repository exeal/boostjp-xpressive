<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>
  <xsl:import href="../boostjp.xsl"/>

  <!-- 1.4. Toc/LoT/Index Generation  -->
  <xsl:param name="generate.section.toc.level" select="3"/>
  <xsl:param name="toc.section.depth">4</xsl:param>

  <!-- 1.21. Chunking -->
  <xsl:param name="chunk.first.sections" select="1"/>
  <xsl:param name="chunk.section.depth" select="3"/>
</xsl:stylesheet>
