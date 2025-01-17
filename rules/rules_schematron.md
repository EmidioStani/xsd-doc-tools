# Rules

This page illustrates the rules followed by the XML schema.

## Schematron Rules

The below table shows the list the schematron rules that can be applied to structure the XML schema automatically:

| Rule  | Rationale | Link |
| ------------- | ------------- | ------------- |
| Simple type definition is top-level  | This rule ensures that simple types are defined globals, therefore they can be reused. | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L23) |
| Simple type has data definition  | This rule ensures that simple types have documentation. | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L29)  |
| Simple type has semantic annotation | This rules ensures that mappings with the original vocabulary is in place. | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L35)  |
| Complex type definition is top-level | This rule ensures that complex types are defined globals, therefore they can be reused. | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L41)  |
| Complex type has data definition |  This rule ensures that complex types have documentation. | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L47)  |
| Complex type and its elements have semantic annotation | This rules ensures that mappings with the original vocabulary is in place. | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L53)  |
| Element declaration is top-level | This rule ensures that elements are defined globals, therefore they can be reused. | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L67)  |
| Schema has data definition | This rule ensures that elements have documentation. | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L73)  |
| Schema has app info | This rule ensures that the XML schema has metadata defined. | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L79)  |
| Schema document defines target namespace  | This rule ensures that the target namespace is present, so all the elements/types belong to it. | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L85)  |
| Schema has version  | This rule ensures that the XML schema has a version.  | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L91)  |
| Schema version follows dot-notation  | This rule ensures that the version follows dot-notation, in practice the same used by the respective vocabulary. | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L97)  |
| xs:import must have namespace  | This rule ensures that namespaces imported must be named. | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L103)  |
| Schema component names have only specific characters  | This rule ensures that certain characters do not appear in the name.  | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L109)  |
| Attribute name begins with lower case letter  | This rule ensures that all attributes start with lower letters. | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L115)  |
| Name of schema component other than attribute and proxy type begins with upper case letter  | This rule ensures that all other types start with capital letters. | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L122)  |
| Name of type ends in "Type"  | This rule ensures that all types names ends with "Type" .  | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L134)  |
| Warning for the use of anyType | This rule ensures in general anyType should not be used but, considering the semantic context, it is allowed with exceptions. | [link](https://github.com/SEMICeu/XML-schema/blob/main/rules/rules_schematron.sch#L143)  |

### How to execute the Rules

In this repository there is a [build.xml](../build.xml) file that can be executed by [Apache Ant](https://ant.apache.org/).
Ant is integrated in certain editors, for example within VSCode the user can install the plugin [Ant Target runner](https://marketplace.visualstudio.com/items?itemName=nickheap.vscode-ant).

The build.xml contains 2 steps:
1) validate, to validate the XML schema against the schematron Rules, using the open source [ph-schematron](https://github.com/phax/ph-schematron) engine.
2) report, to transform the report of schematron in HTML reports more easy to understand, using the open source [Saxon-HE](https://github.com/Saxonica/Saxon-HE) XSLT engine.

At the end of the execution, an "output" folder is generated containing the schematron report and the HTML reports for each XML schema.











