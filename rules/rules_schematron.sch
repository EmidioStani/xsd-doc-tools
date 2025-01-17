<?xml version="1.0" encoding="US-ASCII" standalone="yes"?>

<sch:schema 
  xmlns:sch="http://purl.oclc.org/dsdl/schematron" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:sawsdl="http://www.w3.org/ns/sawsdl" 
  queryBinding="xslt2" >
  
<sch:title>Rules for reference XML Schema documents</sch:title>
   
    
<sch:ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
<sch:ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>
<sch:ns prefix="nf" uri="http://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/#NDRFunctions"/>
<sch:ns prefix="sawsdl" uri="http://www.w3.org/ns/sawsdl"/>
<sch:ns prefix="ct" uri="http://release.niem.gov/niem/conformanceTargets/3.0/"/>
<sch:ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
<sch:ns prefix="appinfo" uri="http://release.niem.gov/niem/appinfo/5.0/"/>
<sch:ns prefix="structures" uri="http://release.niem.gov/niem/structures/5.0/"/>


<sch:pattern id="rule_9-10"><sch:title>Simple type definition is top-level</sch:title>
  <sch:rule context="xs:simpleType">
    <sch:assert role="error" test="exists(parent::xs:schema)">Rule 9-10: A simple type definition MUST be top-level.</sch:assert>
  </sch:rule>
</sch:pattern>

<sch:pattern id="rule_9-12"><sch:title>Simple type has data definition</sch:title>
  <sch:rule context="xs:simpleType">
    <sch:assert role="error" test="some $definition in xs:annotation/xs:documentation[1] satisfies                         string-length(normalize-space(string($definition))) &gt; 0">Rule 9-12: A simple type MUST have a data definition.</sch:assert>
  </sch:rule>
</sch:pattern>

<sch:pattern id="rule_9-12-1"><sch:title>Simple type has semantic annotation</sch:title>
  <sch:rule context="xs:simpleType">
    <sch:assert role="error" test="exists(@sawsdl:modelReference)">Rule 9-12: A simple type MUST have a semantic annotation.</sch:assert>
  </sch:rule>
</sch:pattern>

<sch:pattern id="rule_9-25"><sch:title>Complex type definition is top-level</sch:title>
  <sch:rule context="xs:complexType">
    <sch:assert role="error" test="exists(parent::xs:schema)">Rule 9-25: A complex type definition MUST be top-level.</sch:assert>
  </sch:rule>
</sch:pattern>
            
<sch:pattern id="rule_9-26"><sch:title>Complex type has data definition</sch:title>
  <sch:rule context="xs:complexType">
    <sch:assert role="error" test="some $definition in xs:annotation/xs:documentation[1] satisfies                         string-length(normalize-space(string($definition))) &gt; 0">Rule 9-26: A complex type MUST have a data definition.</sch:assert>
  </sch:rule>
</sch:pattern>

<sch:pattern id="rule_9-12-2">  
  <sch:title>Complex type and its elements have semantic annotation</sch:title>   
  <sch:rule context="xs:complexType">  
    <sch:assert role="error" test="exists(@sawsdl:modelReference)">  
      Rule 9-12: A complex type MUST have a semantic annotation.  
    </sch:assert>  
  </sch:rule>   
  <sch:rule context="xs:complexType//xs:element">  
    <sch:assert role="error" test="exists(@sawsdl:modelReference)">  
      Rule 9-12: An element within a complex type MUST have a semantic annotation.  
    </sch:assert>  
  </sch:rule>  
</sch:pattern>  

<sch:pattern id="rule_9-36"><sch:title>Element declaration is top-level</sch:title>
  <sch:rule context="xs:element[exists(@name)]">
    <sch:assert role="error" test="exists(parent::xs:schema)">Rule 9-36: An element declaration MUST be top-level.</sch:assert>
  </sch:rule>
</sch:pattern>

<sch:pattern id="rule_9-82"><sch:title>Schema has data definition</sch:title>
  <sch:rule context="xs:schema">
    <sch:assert role="error" test="some $definition in (xs:annotation/xs:documentation)[1] satisfies                         string-length(normalize-space(string($definition))) &gt; 0">Rule 9-82: An element xs:schema MUST have a data definition.</sch:assert>
  </sch:rule>
</sch:pattern>

<sch:pattern id="rule_9-82-2"><sch:title>Schema has app info</sch:title>
  <sch:rule context="xs:schema">
    <sch:assert role="error" test="exists(xs:annotation/xs:appinfo)" >Rule 9-82: An element xs:schema MUST have app info.</sch:assert>
  </sch:rule>
</sch:pattern>
          
<sch:pattern id="rule_9-83"><sch:title>Schema document defines target namespace</sch:title>
  <sch:rule context="xs:schema">
    <sch:assert role="error" test="exists(@targetNamespace)">Rule 9-83: The schema MUST define a target namespace.</sch:assert>
  </sch:rule>
</sch:pattern>
          
<sch:pattern id="rule_9-85"><sch:title>Schema has version</sch:title>
  <sch:rule context="xs:schema">
    <sch:assert role="error" test="some $version in @version satisfies                       string-length(normalize-space(@version)) &gt; 0">Rule 9-85: An element xs:schema MUST have an attribute {}version that MUST NOT be empty.</sch:assert>
  </sch:rule>
</sch:pattern>

<sch:pattern id="rule_9-85"><sch:title>Schema version follows dot-notation</sch:title>
  <sch:rule context="xs:schema[exists(@version)]">
    <sch:assert role="error" test="matches (@version, '^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$')" >Rule 9-85: An element xs:schema MUST have an attribute {}version that MUST follow the dot-notation.</sch:assert>
  </sch:rule>
</sch:pattern>

<sch:pattern id="rule_9-90"><sch:title>xs:import must have namespace</sch:title>
  <sch:rule context="xs:import">
    <sch:assert role="error" test="exists(@namespace)">Rule 9-90: An element xs:import MUST have an attribute {}namespace.</sch:assert>
  </sch:rule>
</sch:pattern>

<sch:pattern id="rule_10-46"><sch:title>Schema component names have only specific characters</sch:title>
  <sch:rule context="xs:*[exists(@name)]">
    <sch:assert role="error" test="matches(@name, '^[A-Za-z0-9\-_\.]*$')">Rule 10-46: The name of an XML Schema component defined by the schema must be composed of only the characters uppercase 'A' through 'Z', lowercase 'a' through 'z', numbers '0' through '9', underscore, hyphen, and period.</sch:assert>
  </sch:rule>
</sch:pattern>
        
<sch:pattern id="rule_10-49"><sch:title>Attribute name begins with lower case letter</sch:title>
  <sch:rule context="xs:attribute[exists(@name)]">
    <sch:assert role="error" test="matches(@name, '^[a-z]')">Rule 10-49: Within the schema, any attribute declaration MUST have a name that begins with a lowercase letter
      ('a'-'z').</sch:assert>
  </sch:rule>
</sch:pattern>
          
<sch:pattern id="rule_10-50"><sch:title>Name of schema component other than attribute and proxy type begins with upper case letter</sch:title>
  <sch:rule context="xs:attribute">
    <sch:report test="false()" role="warning">Rule 10-50: This rule does not apply to an attribute.</sch:report>
  </sch:rule>
  <sch:rule context="xs:complexType[some $name in @name,                                     $extension in xs:simpleContent/xs:extension,                                     $base-qname in resolve-QName($extension/@base, $extension) satisfies                                     $base-qname = QName('http://www.w3.org/2001/XMLSchema', $name)]">
    <sch:report test="false()" role="warning">Rule 10-50: This rule does not apply to a proxy types.</sch:report>
  </sch:rule>
  <sch:rule context="xs:*[exists(@name)]">
    <sch:assert role="error" test="matches(@name, '^[A-Z]')">Rule 10-50: Within the schema, an XML Schema component that is not an attribute declaration or proxy type MUST have a name that begins with an upper-case letter ('A'-'Z').</sch:assert>
  </sch:rule>
</sch:pattern>

<sch:pattern id="rule_11-1"><sch:title>Name of type ends in "Type"</sch:title>
  <sch:rule context="xs:complexType[some $name in @name,                                     $extension in xs:simpleContent/xs:extension,                                     $base-qname in resolve-QName($extension/@base, $extension) satisfies                                     $base-qname = QName('http://www.w3.org/2001/XMLSchema', $name)]">
    <sch:report test="false()" role="warning">Rule 11-1: The name of a proxy type does not end in "Type".</sch:report>
  </sch:rule>
  <sch:rule context="xs:*[(self::xs:simpleType or self::xs:complexType) and exists(@name)]">
    <sch:assert role="error" test="ends-with(@name, 'Type')">Rule 11-1: A type definition schema component that does not define a proxy type MUST have a name that ends in "Type".</sch:assert>
  </sch:rule>
</sch:pattern>

<sch:pattern id="rule_11-3"><sch:title>Warning for the use of anyType</sch:title>
  <sch:rule id="rule_11-3" context="xs:element[exists(@type)]">
    <sch:assert role="warning " test="not(resolve-QName(@type, .) = xs:QName('xs:anyType'))">An element should not have a type anyType, unless flexibility is needed.</sch:assert>
  </sch:rule>
</sch:pattern>


</sch:schema>