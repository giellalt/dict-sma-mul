xquery version "1.0";

declare namespace saxon="http://saxon.sf.net/";

declare option saxon:output "doctype-public=-//XMLmind//DTD smanob//SE";
declare option saxon:output "doctype-system=../scripts/smanob.dtd";
declare option saxon:output "method=xml";
declare option saxon:output "encoding=UTF-8";
declare option saxon:output "omit-xml-declaration=no"; 
declare option saxon:output "indent=yes"; 
declare option saxon:output "saxon:indent-spaces=3"; 


(:
    | 
    | NB: One needs the latest version of the SAXON!
    | The input: files to put together
    | Usage: java net.sf.saxon.Query collect-smanob-parts.xql VARIABLE_FIRST=PATH/TO/FILE_FIRST .. VARIABLE_LAST=PATH/TO/FILE_LAST
    | 
:)

declare variable $adj external;
declare variable $noun external;
declare variable $other external;
declare variable $verb external;

<?xml-stylesheet type="text/css" href="../scripts/smanob.css"?>,'
',
<?xml-stylesheet type="text/xsl" href="../scripts/smanob.xsl"?>,'
',
<r> {
  for $element in (doc($adj)//e, doc($noun)//e, doc($other)//e, doc($verb)//e)
  return   $element 
} </r>, '
'
