<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>
  <xsl:import href="../boostjp.xsl"/>

  <!-- 1.4. Toc/LoT/Index Generation  -->
  <xsl:param name="generate.toc">
    article toc,title
    book toc,title
    chapter toc,title
    glossary toc
    section toc,title
  </xsl:param>
  <xsl:param name="manual.toc"/>
  <xsl:param name="process.source.toc" select="1"/>
<!--  <xsl:param name="process.empty.source.toc" select="1"/>-->

  <!-- 1.21. Chunking -->
<!--  <xsl:param name="chunk.first.sections" select="1"/>-->
  <xsl:param name="chunk.separate.lots" select="1"/>
  <xsl:param name="chunk.toc"/>
  <xsl:param name="chunk.tocs.and.lots" select="1"/>
</xsl:stylesheet>
