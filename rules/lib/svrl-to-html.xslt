<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:j4r="http://jats4r.org/ns"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="svrl j4r xsd">

  <xsl:output method="html" omit-xml-declaration="yes" standalone="no" indent="yes"/>

  <xsl:template match="svrl:schematron-output">
  	  <html>
  	  	<head>
  	  	<title>Execution Result</title>
  	  	<link rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.min.css"></link>
  	  	<style>
  	  	tr td:nth-child(1).error{background: red;} 
  	  	tr td:nth-child(1).warning{background: orange;}
  	  	tr td:nth-child(1).info{background: green;}
		td {
			word-break:break-word;			
		}
  	  	</style>
  	  	<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.js"></script>
  	  	<script type="text/javascript" src="https://cdn.datatables.net/2.2.1/js/dataTables.min.js"></script>
  	  </head>
  	  <body>
      <div>
        <p>Rules performed:</p>
        <table id="rules" class="display" style="width:100%">
        <thead>
        	<tr><th>ID</th><th>Name</th><th>Document</th></tr>
        </thead>
        <tbody>
          <xsl:apply-templates select="svrl:active-pattern"/>
        </tbody>
        </table>

        <xsl:variable name='problems' select='svrl:failed-assert|svrl:successful-report'/>
        <xsl:choose>
          <xsl:when test="$problems">
            <p>Problems:</p>
            <table id="results" class="display" style="width:100%">
              <thead>
                <tr>
                  <th>Severity</th>
                  <th>File</th>
                  <th>Location</th>
                  <th>Value</th>
                  <th>Test</th>
                  <th>Message</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="$problems">
                  <xsl:call-template name='problem-report'/>
                </xsl:for-each>
              </tbody>
            </table>
          </xsl:when>
          <xsl:otherwise>
            <p>No problems were found.</p>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <link rel="stylesheet" href="https://codemirror.net/5/lib/codemirror.css" />
      <script src="https://codemirror.net/5/lib/codemirror.js"></script>
      <script src="https://codemirror.net/5/mode/xml/xml.js"></script>
      <script type="text/javascript">
		$(document).ready( function () {
			$('#rules').DataTable();
    		$('#results').DataTable({
			});
    	} );
    	$('.code').each(function(index, elem){
      		var cm=CodeMirror.fromTextArea(elem, {
				mode: "text/html",
        		lineNumbers: true,
				lineWrapping: true
	  	    });
			cm.setSize(400, null);
		});
	</script>
      </body>
      </html>
  </xsl:template>

  <xsl:template match="svrl:active-pattern">
    <tr>
    	<td><xsl:value-of select="@id" /></td>
    	<td><xsl:value-of select="@name" /></td>
    	<td><xsl:value-of select="@document" /></td>
    </tr>
  </xsl:template>

  <xsl:template name='problem-report'>
    <xsl:variable name='document' 
                  select='preceding-sibling::svrl:active-pattern[1]/@document'/>
    <xsl:variable name='location' 
                  select='@location'/>
      <xsl:variable name="testVar" select="substring-after($location, '/')"/>
     <xsl:variable name="object" select="document($document)" />
      <xsl:variable name="input" as="node()">
        <xsl:evaluate xpath="$location" context-item="$object"/>
    </xsl:variable>
    <xsl:variable name='level' select="@role" />
    <tr>
      <td class='{$level}'>
     	 <xsl:value-of select='@role'/>
      </td>
      <td class='{$level}'>
      	<a href="{$document}"><xsl:value-of select="$document" /></a>
      </td>
      <td class='{$level}'>
        <!-- Insert zero-width spaces to allow the browser to wrap the location cell -->
        <span class='xpath-display'>
          <xsl:value-of select="replace(@location, '/', '&#x200B;/&#x200B;')"/>
        </span>
        <span class='xpath-location'>
          <xsl:value-of select='@location'/>
        </span>
      </td>
       <td  class='{$level}'>
        <span class='xpath-value'>
        <textarea class="code">
         <xsl:copy-of select="$input"/>
        </textarea>
        </span>
      </td>
      <td  class='{$level}'>
        <span class='xpath-location'>
          <xsl:value-of select='@test'/>
        </span>
      </td>
      <td class='{$level}'>
        <xsl:apply-templates select="svrl:text"/>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
