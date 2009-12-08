Incoming files to the smamob dictionary.

These files are entries on their way to a smanob dictionary.

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

1. Empty rest.csv to the other files, primarily to noun.csv.
2. Make the lemma entries unique.
3. Make the csv files adjust to the target format.
4. Do the conversion. @cip: done!

Just try the following:

java -Xmx2048m net.sf.saxon.Transform -it main table2xml.xsl inFile=test_t2x.csv

and after that have a look at the output

vi out/test_t2x.csv.xml



5. etc.


POS tags:
v1, ..., v6, and the rest (odd, contract, irregularI) are "v".

