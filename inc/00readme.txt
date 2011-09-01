Incoming files to the smamob dictionary.

These files are entries on their way to a smanob dictionary.

Simple scripts to check already transformed xml files with the whole src dir or with specific files:
search_entry_in_dir.xsl
search_entry_in_file.xsl

File listing:
1. lemma_not_in_dict/newsmalemmat_duodji.xml - These entries are not in src dir (checked by cip 29.08.2011)
   Lenes kommentarer:
    - tjååbpehke er bøyd form av tjaebpies - fjerna fra lista
    - daable ,  se daabloe, er dette en skrivefeil eller er det en variant ?
    - guelmesne, vi har denne som eksempel under lemmaet guelmie (Sg Inn) men vi burde legge den til som po ?
    - sjyjjedh, må legges til i fst


The files are on the csv (comma separated) format, like this:
"lemma"<tab>"POS"<tab>"translation"<tab>"...

The fourth field onwards is heterogenous. Some files miss the POS field.

The files have to be in the folloing table format:
lemma<SPACE>_<SPACE>POS<SPACE>_<SPACE>meaning_1<COMMA>meaning_2<COMMA>meaning_3<SEMICOLON>meaning_n ...

The resulting csv files should then be converted to xml and fed to 
our dictionary platforms.

The major challenge in this phase is to reduce the multiple entries of
the sma lemmas. (@cip: ???)


Todolist:

1. Make the lemma entries unique.
2. Make the csv files adjust to the target format.
3. Do the conversion. @cip: done!

@cips-comment: Bad bookkeeping of the csv-files, one doesn't know
which file are already transformed and which not. Partly my fault,
I should have deleted all files already merged into the existing smanob dict.



Just try the following:

java -Xmx2048m net.sf.saxon.Transform -it main table2xml.xsl inFile=test_t2x.csv

and after that have a look at the output

vi out/test_t2x.csv.xml



5. etc.


POS tags:
v1, ..., v6, and the rest (odd, contract, irregularI) are "v".

