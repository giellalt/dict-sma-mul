#!/bin/bash

# Script to pair sma and nob from the smanob.xml file
# This file is called from the makefile.

echo "LEXICON Root" > ../bin/sn.lexc

cat smanob.xml | tr '\n' ' ' | sed 's/<e>/£/g' | tr '£' '\n' | sed 's/pos=/£/g' | cut -d"£" -f2 | cut -d">" -f2 | cut -d"<" -f1 | grep '[A-Za-z0-9]' | tr ' ' '_' > ../bin/s.dic
cat smanob.xml | tr '\n' ' ' | sed 's/<e>/£/g' | tr '£' '\n' | sed 's/pos=/£/g' | cut -d"£" -f3 | cut -d">" -f2 | cut -d"<" -f1 | grep '[A-Za-z0-9]' | tr ' ' '_' > ../bin/n.dic


paste -d":" ../bin/s.dic ../bin/n.dic > ../bin/sn.list

cat ../bin/sn.list | sed 's/$/ # ;/g' >> ../bin/sn.lexc


