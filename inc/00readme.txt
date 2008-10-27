Incoming files to the smamob dictionary.

These files are entries on their way to a smanob dictionary.

The files are on the csv (comma separated) format, like this:
"lemma"<tab>"POS"<tab>"translation"<tab>"...

The fourth field onwards is heterogenous. Some files miss the POS field.

What we want is apporoximately this:

"lemma"<tab>"POS"<tab>"translation(s)"<tab>"example"<tab>"translation"

The resulting csv files should then be converted to xml and fed to 
our dictionary platforms.

The major challenge in this phase is to reduce the multiple entries of
the sma lemmas.

Status quo:

     121 adj.csv
     145 adv.csv
      70 closed.csv
    1445 noun.csv
    1358 rest.csv
     361 vI.csv
      21 vII.csv
       9 vIII.csv
     102 vIV.csv
    1688 vOdd.csv
      16 vV.csv
      36 vVI.csv

Todolist:

1. Empty rest.csv to the other files, primarily to noun.csv.
2. Make the lemma entries unique.
3. Make the csv files adjust to the target format.
4. Do the conversion.
5. etc.


POS tags:
v1, ..., v6, and the rest (odd, contract, irregularI) are "v".

