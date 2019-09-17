<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl">
<xsl:output method="text" version="1.0" encoding="UTF-8"/> 

<xsl:strip-space elements="*"/>

<xsl:template match="/refSys/refMap/map">
<xsl:value-of select="@from"/><xsl:text>&#x9;</xsl:text><xsl:value-of select="@to"/><xsl:text>&#xd;&#xa;</xsl:text>
</xsl:template>

</xsl:stylesheet>