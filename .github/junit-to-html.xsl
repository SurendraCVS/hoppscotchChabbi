<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <title>Hoppscotch Test Results</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 20px; }
          h1 { color: #333; }
          .summary { background-color: #f0f0f0; padding: 10px; border-radius: 5px; margin-bottom: 20px; }
          .success { color: green; }
          .failure { color: red; }
          table { border-collapse: collapse; width: 100%; }
          th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
          th { background-color: #f2f2f2; }
          tr:nth-child(even) { background-color: #f9f9f9; }
          .testcase { margin-bottom: 10px; border: 1px solid #ddd; padding: 10px; }
          .testcase-name { font-weight: bold; }
          .testcase-time { color: #666; }
        </style>
      </head>
      <body>
        <h1>Hoppscotch Test Results</h1>
        
        <div class="summary">
          <h2>Summary</h2>
          <p>
            Total tests: <xsl:value-of select="count(//testcase)"/>, 
            Failures: <xsl:value-of select="count(//failure)"/>, 
            Errors: <xsl:value-of select="count(//error)"/>,
            Time: <xsl:value-of select="sum(//testcase/@time)"/> seconds
          </p>
        </div>
        
        <h2>Test Suites</h2>
        <xsl:for-each select="//testsuite">
          <div class="testsuite">
            <h3>
              <xsl:value-of select="@name"/>
              <span class="testcase-time"> (<xsl:value-of select="@time"/> seconds)</span>
            </h3>
            
            <table>
              <tr>
                <th>Test</th>
                <th>Status</th>
                <th>Time (s)</th>
                <th>Details</th>
              </tr>
              <xsl:for-each select="testcase">
                <tr>
                  <td><xsl:value-of select="@name"/></td>
                  <td>
                    <xsl:choose>
                      <xsl:when test="failure">
                        <span class="failure">FAILED</span>
                      </xsl:when>
                      <xsl:when test="error">
                        <span class="failure">ERROR</span>
                      </xsl:when>
                      <xsl:otherwise>
                        <span class="success">PASSED</span>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>
                  <td><xsl:value-of select="@time"/></td>
                  <td>
                    <xsl:if test="failure">
                      <pre><xsl:value-of select="failure/@message"/></pre>
                    </xsl:if>
                    <xsl:if test="error">
                      <pre><xsl:value-of select="error/@message"/></pre>
                    </xsl:if>
                  </td>
                </tr>
              </xsl:for-each>
            </table>
          </div>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet> 
