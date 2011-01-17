Issues for the smanob version 2011:

1. checking the entries:
1.1 well-formed entries
1.2 no xxx tags
1.3 no double entries, even not als orthographic variants which I generate using the pipeline
      (for instance, musihke and musïhke ... or so in the latest entries from the income-dir)
 1.4 no double entries with both dashed end non-dashed compounds
       (no optional dashed word as lemma: for instance, øvtiedimmiesoptsestalleme  _  utviklingssamtale vs. øvtiedimmie-soptsestalleme  _  utviklingssamtale)
   At the moment, there are

Todo_jan2011>grep '-' 20110113_001-200_noun_not_in_dict.csv | grep -v xxx | wc -l
     45
dashed entries in the last income file (nouns).

2. coverage: please check the entries that did not get a paradim during generation.
  According to Trond, there are sub-variants, but then one has to decide what to do with them
  (leave them out, take them marked accordingly, etc.)

3. decide upon the format of dictionary and its content depending on the format
 (For instance, no proper nouns in the mobile version)

====================
what to do with that? (no "dict" tag)

   <e>
      <lg>
         <l pos="a">båetije</l>
      </lg>
      <mg>
         <tg>
            <t decl="4" pos="a">kommende</t>
         </tg>
      </mg>
   </e>
====================
general check of braketed stuff, is it perhaps some re-element?

pr_smanob.xml:            <t dict="yes" oa="yes" pos="pr" tcomm="no">til (nær)</t>
pr_smanob.xml:            <t dict="yes" oa="yes" pos="pr" tcomm="no">uten (flere)</t>
pr_smanob.xml:            <t dict="yes" oa="yes" pos="pr" tcomm="no">hitenfor (flere)</t>
pr_smanob.xml:            <t dict="yes" oa="yes" pos="pr" tcomm="no">vestafor (flere)</t>
pr_smanob.xml:               <xt>Gå vestafor de snaufjellene (med krattskog omkring)!</xt>
pr_smanob.xml:            <t dict="yes" oa="yes" pos="pr" tcomm="no">østafor (flere steder)</t>
pr_smanob.xml:            <t dict="yes" oa="yes" pos="pr" tcomm="no">innenfor (flere)</t>
pronIndef_smanob.xml:               <xt>mor og barn (fast uttrykk)</xt>
====================
I thought that the han/hun-problem has been solved, Lene?

pronPers_smanob.xml:            <t dict="yes" oa="yes" pos="pron" stat="pref" tcomm="no">dere to (du og han/hun
)</t>
pronPers_smanob.xml:            <t dict="yes" oa="yes" pos="pron" stat="pref" tcomm="no">dere (du og han/hun)</
t>
pronPers_smanob.xml:            <t dict="yes" oa="yes" pos="pron" stat="pref" tcomm="no">dere to (du og han/hun
)</t>
pronPers_smanob.xml:            <t dict="yes" oa="yes" pos="pron" stat="pref" tcomm="no">dere to (deg og ham/he
nne)</t>
====================



