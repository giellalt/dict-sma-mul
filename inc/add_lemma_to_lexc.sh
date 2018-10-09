#!/bin/bash

missing_file="aejvie_v.test"
lexc_file="$GTHOME/langs/sma/src/morphology/stems/verbs.lexc"

while read line;
  do 
  echo "#$line+Sem/Dummytag:$line LEXXX ;" >> $lexc_file;
  echo "added lemma $line to $lexc_file";
done < $missing_file

