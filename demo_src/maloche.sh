#!/bin/sh

for tlang in nob sme eng deu
do
    echo "inverting the sma* dict into $tlang"
    java -Xmx2048m net.sf.saxon.Transform -it main gt_sd2td.xsl inFile=demo_noun_profession_sma.xml trgl=$tlang
    java -Xmx2048m net.sf.saxon.Transform -it main gt_mergeEntry_td.xsl inFile=outDir/demo_noun_profession_sma_$tlang.xml
    echo "$tlang done"
done

