Incoming files to the smamob dictionary.


These files contain entries, some of them on their way to a smanob dictionary.



Evaluation of inc directory 14.9.2011 (cip/trond):

* Todo_jan2011               = See 00readme.txt in catalogue
* basis_files                = See 00readme.txt in catalogue
* clarify_status             = Ignore for now.
* csv_dir                    = Ignore for now.
* in_verb.csv                = to be added to xml
* lemma_not_in_dict          = Not translated. Ignore for now.
* new_noun_inc.csv           = to be added to xml
* not_in_fst                 = Some translated and some not, but not in sma.fst. Ignore for now.
* search_entry_in_dir.xsl    = script
* search_entry_in_file.xsl   = script
* table2xml.xsl              = script
* verb_sg3_mismatch.txt      = Ignore for now. Later: "ta en sjekk og stryke ut verb som er ok (S/M)"
* elgao_skole_20111022       = new data in original format from the Elgå Skole URL (see Bug 1195)

---------------


Older comments on some of the files:


Simple scripts to check already transformed xml files with the whole src dir or with specific files:
search_entry_in_dir.xsl
search_entry_in_file.xsl

pron_fst_missing_in_dict.txt
Denne fila inneholder ordformer som ikke er i dict, men det kan hende at noen former er overgenerering, og noen former er kanskje ikke i bruk? For de som skal skal legges til i dict, må man vurdere om man evt. skal bruke statiske paradigmer.

verb_sg3_mismatch.txt
Her er det verb som enten har to forskjellige bøyningsmønstre i fst, eller at bøyningsmønsteret i fst ikke stemmer med annen informasjon. Jeg tror vi har sett på de fleste av disser verbene tidligere, men man kan ta en sjekk og stryke ut verb som er ok.

File listing in dir lemma_not_in_dict:
1. newsmalemmat_duodji.xml - These entries are not in src dir (cip 29.08.2011)
   Lenes kommentarer:
    - tjååbpehke er bøyd form av tjaebpies - fjerna fra lista
    - daable ,  se daabloe, er dette en skrivefeil eller er det en variant ?
    - guelmesne, vi har denne som eksempel under lemmaet guelmie (Sg Inn) men vi burde legge den til som po ?
    - sjyjjedh, må legges til i fst

2. freq_ADJ_lemma-pos_to-check.xml - These entries are not in src dir. (cip 01.09.2011) 



Open questions:
What about this file: adj_not_in_fst.txt? Is it neither in dict nor in fst?



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


Genuine instances of <te>-element found:

   <e>
      <lg>
         <l pos="pcle">gih</l>
      </lg>
      <mg>
    <tg>
      <te>forsterkende nektelse</te>
    </tg>
      </mg>
   </e>
   <e>
      <lg>
         <l pos="pcle">gan</l>
      </lg>
      <mg>
         <tg>
            <te>forsterkende nektelse</te>
         </tg>
      </mg>
   </e>
   <e>
      <lg>
         <l pos="pcle">goh</l>
      </lg>
      <mg>
         <tg>
            <te>forsterkende nektelse</te>
         </tg>
      </mg>
   </e>

The list 20100920_missing.txt in the 20100920 dir have to be
checked properly. It is ful of "noise".
Ex.
fisk
verb
bra
bil
√¶nngan
stavelse
siden
sette
¦jja
√•nnoeh
√•arjelh-saemien
øøhpehtimmieraerie
ööpehtimmie
ööhpehtimmiesijjie
√čtin
søster
¥rrodh
......... and so on
