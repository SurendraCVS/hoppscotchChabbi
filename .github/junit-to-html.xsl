<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <title>Hoppscotch API Test Dashboard</title>
        <style>
          :root {
            --primary-color: #7D4CDB;
            --success-color: #00C781;
            --warning-color: #FFAA15;
            --error-color: #FF4040;
            --info-color: #3D138D;
            --text-color: #444444;
            --light-bg: #f5f7fa;
            --card-bg: #ffffff;
            --border-color: #e2e8f0;
          }
          
          body {
            font-family: 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            margin: 0;
            padding: 0;
            color: var(--text-color);
            background-color: var(--light-bg);
          }
          
          .dashboard {
            padding: 2rem;
          }
          
          header {
            background-color: var(--primary-color);
            color: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
          }
          
          h1 {
            margin: 0;
            font-weight: 500;
          }
          
          .summary-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin: 1.5rem 0;
          }
          
          .summary-card {
            background-color: var(--card-bg);
            border-radius: 8px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            text-align: center;
            transition: transform 0.2s;
            border-top: 4px solid var(--primary-color);
          }
          
          .summary-card:hover {
            transform: translateY(-5px);
          }
          
          .stat-value {
            font-size: 2rem;
            font-weight: bold;
            margin: 0.5rem 0;
          }
          
          .stat-label {
            text-transform: uppercase;
            font-size: 0.85rem;
            color: #666;
            letter-spacing: 1px;
          }
          
          .success-card { border-top-color: var(--success-color); }
          .error-card { border-top-color: var(--error-color); }
          .warning-card { border-top-color: var(--warning-color); }
          .info-card { border-top-color: var(--info-color); }
          
          .testsuite-container {
            background-color: var(--card-bg);
            border-radius: 8px;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            overflow: hidden;
          }
          
          .testsuite-header {
            padding: 1rem 1.5rem;
            background-color: #f8fafc;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
          }
          
          .testsuite-name {
            font-size: 1.25rem;
            color: var(--primary-color);
            font-weight: 500;
            margin: 0;
          }
          
          .testsuite-time {
            color: #666;
            font-size: 0.9rem;
            background-color: rgba(125, 76, 219, 0.1);
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
          }
          
          table {
            width: 100%;
            border-collapse: collapse;
          }
          
          th {
            text-align: left;
            padding: 1rem 1.5rem;
            background-color: #f8fafc;
            color: #64748b;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 1px;
            border-bottom: 1px solid var(--border-color);
          }
          
          td {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
            vertical-align: middle;
            text-align: left;
          }
          
          .time-cell {
            text-align: center;
            font-family: monospace;
            font-weight: 500;
          }
          
          tr:last-child td {
            border-bottom: none;
          }
          
          tr:hover {
            background-color: #f8fafc;
          }
          
          .status {
            font-weight: 600;
            border-radius: 20px;
            padding: 0.25rem 0.75rem;
            text-align: center;
            display: inline-block;
            min-width: 80px;
          }
          
          .status-passed {
            background-color: rgba(0, 199, 129, 0.1);
            color: var(--success-color);
          }
          
          .status-failed {
            background-color: rgba(255, 64, 64, 0.1);
            color: var(--error-color);
          }
          
          .status-error {
            background-color: rgba(255, 170, 21, 0.1);
            color: var(--warning-color);
          }
          
          .details-container {
            background-color: #f8fafc;
            border-radius: 4px;
            padding: 1rem;
            margin-top: 0.5rem;
            max-height: 200px;
            overflow: auto;
            font-family: monospace;
            font-size: 0.9rem;
            border-left: 3px solid var(--error-color);
          }
          
          .timestamp {
            color: #666;
            font-size: 0.85rem;
            margin-top: 2rem;
            text-align: center;
            padding: 1rem;
            background-color: var(--card-bg);
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
          }
          
          .no-tests {
            text-align: center;
            padding: 2rem;
            color: #64748b;
          }
          
          /* Status column alignment */
          .status-column {
            text-align: center;
          }
          
          /* Test stats in header */
          .suite-stats {
            margin-left: 1rem;
            font-size: 0.85rem;
            color: #64748b;
            font-weight: normal;
          }
          
          @media (max-width: 768px) {
            .summary-container {
              grid-template-columns: 1fr;
            }
            
            .dashboard {
              padding: 1rem;
            }
          }
        </style>
      </head>
      <body>
        <header>
          <h1>Hoppscotch API Test Dashboard</h1>
        </header>
        
        <div class="dashboard">
          <!-- Summary Cards -->
          <div class="summary-container">
            <div class="summary-card success-card">
              <div class="stat-value"><xsl:value-of select="count(//testcase)"/></div>
              <div class="stat-label">Total Tests</div>
            </div>
            
            <div class="summary-card success-card">
              <div class="stat-value">
                <xsl:value-of select="count(//testcase) - count(//failure) - count(//error)"/>
              </div>
              <div class="stat-label">Passed</div>
            </div>
            
            <div class="summary-card error-card">
              <div class="stat-value"><xsl:value-of select="count(//failure)"/></div>
              <div class="stat-label">Failed</div>
            </div>
            
            <div class="summary-card warning-card">
              <div class="stat-value"><xsl:value-of select="count(//error)"/></div>
              <div class="stat-label">Errors</div>
            </div>
            
            <div class="summary-card info-card">
              <div class="stat-value">
                <!-- Calculate total time from all testcases -->
                <xsl:variable name="totalTime">
                  <xsl:choose>
                    <xsl:when test="sum(//testcase/@time) > 0">
                      <xsl:value-of select="format-number(sum(//testcase/@time), '0.000')"/>
                    </xsl:when>
                    <xsl:otherwise>0.000</xsl:otherwise>
                  </xsl:choose>
                </xsl:variable>
                <xsl:value-of select="$totalTime"/>
              </div>
              <div class="stat-label">Total Time (s)</div>
            </div>
          </div>
          
          <!-- Test Suites -->
          <h2>Test Suites</h2>
          
          <xsl:choose>
            <xsl:when test="count(//testsuite) > 0">
              <xsl:for-each select="//testsuite">
                <div class="testsuite-container">
                  <div class="testsuite-header">
                    <h3 class="testsuite-name">
                      <xsl:value-of select="@name"/>
                      <!-- Calculate tests, passes, failures for this suite -->
                      <span class="suite-stats">
                        <xsl:value-of select="count(testcase)"/> tests, 
                        <xsl:value-of select="count(testcase) - count(testcase/failure) - count(testcase/error)"/> passed,
                        <xsl:value-of select="count(testcase/failure)"/> failed,
                        <xsl:value-of select="count(testcase/error)"/> errors
                      </span>
                    </h3>
                    
                    <!-- Format the time with 3 decimal places -->
                    <span class="testsuite-time">
                      <xsl:choose>
                        <xsl:when test="@time">
                          <xsl:value-of select="format-number(@time, '0.000')"/> seconds
                        </xsl:when>
                        <xsl:otherwise>0.000 seconds</xsl:otherwise>
                      </xsl:choose>
                    </span>
                  </div>
                  
                  <table>
                    <thead>
                      <tr>
                        <th>Test Name</th>
                        <th class="status-column">Status</th>
                        <th style="text-align: center;">Time (s)</th>
                        <th>Details</th>
                      </tr>
                    </thead>
                    <tbody>
                      <xsl:for-each select="testcase">
                        <tr>
                          <td><xsl:value-of select="@name"/></td>
                          <td class="status-column">
                            <xsl:choose>
                              <xsl:when test="failure">
                                <span class="status status-failed">FAILED</span>
                              </xsl:when>
                              <xsl:when test="error">
                                <span class="status status-error">ERROR</span>
                              </xsl:when>
                              <xsl:otherwise>
                                <span class="status status-passed">PASSED</span>
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td class="time-cell">
                            <xsl:choose>
                              <xsl:when test="@time">
                                <xsl:value-of select="format-number(@time, '0.000')"/>
                              </xsl:when>
                              <xsl:otherwise>0.000</xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td>
                            <xsl:if test="failure">
                              <div class="details-container">
                                <strong>Failure: </strong>
                                <xsl:value-of select="failure/@message"/>
                                <xsl:if test="failure/text()">
                                  <pre><xsl:value-of select="failure/text()"/></pre>
                                </xsl:if>
                              </div>
                            </xsl:if>
                            <xsl:if test="error">
                              <div class="details-container">
                                <strong>Error: </strong>
                                <xsl:value-of select="error/@message"/>
                                <xsl:if test="error/text()">
                                  <pre><xsl:value-of select="error/text()"/></pre>
                                </xsl:if>
                              </div>
                            </xsl:if>
                            <xsl:if test="system-out">
                              <details>
                                <summary>System Output</summary>
                                <div class="details-container">
                                  <pre><xsl:value-of select="system-out"/></pre>
                                </div>
                              </details>
                            </xsl:if>
                          </td>
                        </tr>
                      </xsl:for-each>
                    </tbody>
                  </table>
                </div>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <div class="no-tests">No test suites found in the report.</div>
            </xsl:otherwise>
          </xsl:choose>
          
          <div class="timestamp">
            Report generated on: <xsl:value-of select="//testsuite/@timestamp"/><br/>
            <em>Powered by Hoppscotch API Tests</em>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet> 
