#!/bin/sh

for tlang in nob sme eng deu
do
    for xfile in $(ls demo_*_sma.xml)
    do
	name=$(echo $xfile | cut -d"." -f1)
	echo "inverting the sma* dict into $tlang: $xfile --- $name"
	java -Xmx2048m net.sf.saxon.Transform -it main gt_sd2td.xsl inFile=$xfile trgl=$tlang
	java -Xmx2048m net.sf.saxon.Transform -it main gt_mergeEntry_td.xsl inFile=outDir/$name\_$tlang.xml
	echo "$tlang done"
    done
done

