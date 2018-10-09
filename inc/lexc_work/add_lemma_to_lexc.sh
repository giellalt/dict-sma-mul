#!/bin/bash

missing_file="aejvie_n.test"
lexc_file="$GTHOME/langs/sma/src/morphology/stems/nouns.lexc"

while read line;
  do 
  echo "#$line+Sem/Dummytag:$line LEXXX ;" >> $lexc_file;
  echo "added lemma $line to $lexc_file";
done < $missing_file

