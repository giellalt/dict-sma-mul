
# Dette skal bli ei makefil for å lage smanob.fst, 
# ei fst-fil som tar sma og gjev ei nob-omsetjing.

# Førebels er det berre eit shellscript.
# Kommando for å lage smanob.fst

# sh smanob.sh 

echo 
echo "Etter at dette scriptet er ferdig står du i xfst med promten"
echo "xfst[1]"
echo 
echo "Gjör då dette:"
echo "invert"
echo "save bin/smanob.fst"
echo "quit"
echo ""
echo "LEXICON Root" > bin/smanob_sh.lexc

cat  src/*_smanob.xml | \
egrep -v '<(lc|lsub|analysis)>' | \
egrep -v '<lemma_ref' | \
egrep -v '<stem ' | \
tr '\n' '™' | sed 's/<e/£/g;'| tr '£' '\n'| \
sed 's/<re>[^>]*>//g;'|tr '<' '>'| cut -d">" -f6,16| \
tr ' ' '_'| sed 's/:/%/g;'|tr '>' ':'| \
grep -v '__'| \
grep -v 'xml-stylesheet_alternate' | \
sed 's/$/ # ;/g' >> bin/smanob_sh.lexc

xfst -e "read lexc < bin/smanob_sh.lexc"



