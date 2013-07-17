<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<!-- ############################################################################################################## -->
<!-- Template principal                                                                                             -->
<!--   - corps HTML                                                                                                 -->
<!--   - styles                                                                                                     -->
<!-- ############################################################################################################## -->

<xsl:template match="/">
  <html>
  <head>
    <title>PRGrep <xsl:value-of select="search_result/search_string"/></title>
    <style type="text/css">
      body    { font-size:11px; font-family:'Trebuchet MS',Verdana,Arial,sans-serif; background-color:white; }
      code    { font-size:11px; font-family:'Lucida console',monospace; }
      h1      { font-size:16px; text-decoration:underline; color:blue; background-color:white; text-align:center; }
      h1 b    { color:red; background-color:white; font-family:'Lucida console',monospace; font-size:15px; font-weight:bold; }
      p b     { font-size:10px; font-weight:normal; }
      th,td   { font-size:11px; }
      th      { background:#8080FF; color:white; }
      td      { vertical-align:top; } 
      td.dark { background:#C0C0FF; color:black; }
      td.light  { background:#E0E0FF; color:black; }
      td.p1   { text-align:right; }
      td.p2   { background:white; font-weight:bold; border:1px solid black; }
      td.p3   { background:white; text-align:center; vertical-align:middle; height:30px; }
    </style>
  </head>
  <body>
    <xsl:apply-templates/>
  </body>
  </html>
</xsl:template>

<!-- ############################################################################################################## -->
<!-- Traitement des résultats                                                                                       -->
<!-- ############################################################################################################## -->

<xsl:template match="search_result">
  <p><b>PRGrep <xsl:value-of select="tool_version"/><br/>(<xsl:value-of select="tool_date"/>)<br/>&#169; PRSoftware</b></p>

  <!-- Titre -->

  <h1>
    <xsl:value-of select="title" disable-output-escaping="yes"/>
  </h1>
  <p>&#160;</p>
  <center>

  <!-- Table des paramètres de la recherche -->

  <table border='1' style='border-collapse:collapse; background:#E0E0E0;'>
    <tr>
      <th height='30'><xsl:value-of select="headers/@param"/></th>
    </tr>
    <tr>
      <td>
        <table border='0' cellpadding='3' cellspacing='10'>
          <tr>
            <td class='p1'><xsl:value-of select="search_filter/@text"/> :</td>
            <td class='p2'><xsl:value-of select="search_filter"/></td>
            <td width='30'> </td>
            <td class='p1'><xsl:value-of select="exclude_filter/@text"/> :</td>
            <td class='p2'><xsl:value-of select="exclude_filter"/></td>
          </tr>
          <tr>
            <td class='p1'><xsl:value-of select="search_string/@text"/> :</td>
            <td class='p2'><xsl:value-of select="search_string"/></td>
            <td> </td>
            <td class='p1'><xsl:value-of select="exclude_string/@text"/> :</td>
            <td class='p2'><xsl:value-of select="exclude_string"/></td>
          </tr>
          <tr>
            <td class='p1'><xsl:value-of select="search_mode/@text"/> :</td>
            <td class='p2'><xsl:value-of select="search_mode"/></td>
            <td> </td>
            <td class='p1'><xsl:value-of select="exclude_mode/@text"/> :</td>
            <td class='p2'><xsl:value-of select="exclude_mode"/></td>
          </tr>
          <tr>
            <td class='p1'><xsl:value-of select="dir/@text"/> :</td>
            <td class='p2'>
              <xsl:for-each select="dir">
                <xsl:value-of select="."/>
                <xsl:if test="position() &lt; last()">
                  <xsl:text>;</xsl:text>
                </xsl:if>
              </xsl:for-each>
            </td>
            <td>&#160;</td>
            <td class='p1'><xsl:value-of select="search_date/@text"/> :</td>
            <td class='p2'><xsl:value-of select="search_date"/></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td class='p3'><xsl:value-of select="result"/></td>
    </tr>
  </table>
  <p>&#160;</p>

  <!-- Table des résultats -->

  <table border='1' cellpadding='10' width='90%' style='border-collapse:collapse;'>
    <tr>
      <th><xsl:value-of select="headers/@file"/></th>
      <th><xsl:value-of select="headers/@line"/></th>
      <th><xsl:value-of select="headers/@text"/></th>
    </tr>

    <xsl:for-each select="file">

      <!-- Nom du fichier -->

      <tr>
        <xsl:choose>
          <xsl:when test="@num mod 2 = 0">
            <xsl:call-template name="displayFile">
              <xsl:with-param name="class">dark</xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="displayFile">
              <xsl:with-param name="class">light</xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </tr>

      <!-- Liste des lignes -->

      <xsl:for-each select="found">
        <xsl:if test="@num != 1">
          <tr>
            <xsl:choose>
              <xsl:when test="../@num mod 2 = 0">
                <xsl:call-template name="displayLine">
                  <xsl:with-param name="class">dark</xsl:with-param>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="displayLine">
                  <xsl:with-param name="class">light</xsl:with-param>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </tr>
        </xsl:if>
      </xsl:for-each>

    </xsl:for-each>

  </table>

  </center>
</xsl:template>

<!-- ############################################################################################################## -->
<!-- Affichage de la 1ère ligne d'un fichier                                                                        -->
<!-- ############################################################################################################## -->

<xsl:template name="displayFile">

  <xsl:param name="class"/>

  <td class="{$class}" rowspan="{@found}"><a href="file://{path}" type='text/plain'><xsl:value-of select="path"/></a></td>
  <td class="{$class}" align="center"><xsl:value-of select="./found[1]/@pos"/></td>
  <td class="{$class}"><code><xsl:value-of select="./found[1]"/></code></td>

</xsl:template>

<!-- ############################################################################################################## -->
<!-- Affichage des lignes suivantes d'un fichier                                                                    -->
<!-- ############################################################################################################## -->

<xsl:template name="displayLine">

  <xsl:param name="class"/>

  <td class="{$class}" align="center"><xsl:value-of select="@pos"/></td>
  <td class="{$class}"><code><xsl:value-of select="."/></code></td>

</xsl:template>

</xsl:stylesheet>
