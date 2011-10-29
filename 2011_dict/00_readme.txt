Paradigm generation with an FST borrowed from Lene
resulted in empty generation for the lemmata listed in these files.
Please check and if needed correct the fst and/or the source files.

Alt er ok? Veldig <tysk bundeskanzlerin>ig!
 ==> ikke lenge

Issues to fix:

1) Nå fungerer linkingen i misc_stat_smanob.xml - men eksemplene er fremdeles ikke med
 ==> done (reason vas the lack on lang flag on the tg elements)

2) Entryer som har lang="sme" i kildefila, får et tomt mg-element i den kompilerte ordboka, f.eks. gåeskie. baalhka er har to tomme mg-elementer!
 ==> done

3) <te> elementet er ikke synlig (det var det samme problemet sist)
 ==> done

4) Jeg ser også at l_ref ikke er implementert, men det er en helt ny feature. Vi kan ta det i smenobVD. Det er uansett ikke så mange av dem i smadict

 ==> underspecification wrt. directionality: unidirectional or bidirectional?
     if bidirectional, info in source files perhaps needed

 @trond: Det som er meint er ''unidireksjonal''.  Men dette har låg prioritet.

Inconsistencies in the source files:
1. l_ref in the lg-element:
      <lg>
         <l pos="pron" pg="no" type="indef">mijgih</l>
         <l_ref>maamgih_pron_indef</l_ref>
      </lg>

      <lg>
         <l pos="adv">gosse</l>
            <l_ref>gåabph_adv</l_ref>
      </lg>

vs.
2. l_ref in the tg-element:

         <tg xml:lang="nob">
            <re>om to som hører sammen</re>
            <t pos="cc">og</t>
            <l_ref>jïh_cc</l_ref>
            <xg>
               <x>Manne aadtjegh aahka gon aajjan luvnie vearadamme.</x>
               <xt>Jeg har nettopp vært hos bestemor og bestefar.</xt>
            </xg>
         </tg>

 - constructing the single test file for this issue ==> done

mellom lemma og Eksempler,  teksten 'Se også:' i italics, selve l_ref i normal med understrek for å vise at det er link.

Eksempel:


jallh

konj.
    eller

Se også <underline>vuj</underline>

Eksempler:
jkljfkladsjdfklsjlkdsf
 ==> done and tested
 
5) te-elementene uten parantes, bare i italics
 ==> done

6) pgv manglende v1,v2 i pipeline endringer i miniparadigmer:
   inkludere N+Sg+Nom, Pron+Indef+Sg+Nom og V+Inf
 ==> done

Last minute wishes:

7 --> 1) VGen
vi vil fjerne teksten i miniparadgimet (dïhte båata) og vi vil ha 'verbgen.' som tag istedenfor 'gen. v.'
 ==> done and tested

8 --> 2) ill="no" er ikke implementert i denne ordboka. Den skal fungere på samme måte som i smenob - at den ikke tar med flertallsform i miniparadigmet.

Nei, ill er ikke implementert, det finnes ingen ill=. Det er kanskje illpl ment:
<l illpl="no" margo="e" pos="n" soggi="ie" stem="3syll">jemhkelde</l>

 - constructing the single test file for this issue ==> done

 ==> done and tested

9 --> 3) verb - vi vil ha infinitivsmerket 'å' foran de norske oversettelsene, på samme måte som i smenob.
 
==> check also the static files for this feature

src>grep '<t ' vCop_stat_smanob.xml | sort | uniq -c 
   8             <t pos="v">er</t>
  18             <t pos="v">var</t>
   8             <t pos="v">är</t>
src>grep '<t ' v | sort | uniq -c 
vCop_stat_smanob.xml  vNeg_stat_smanob.xml  v_smanob.xml          
src>grep '<t ' vNeg_stat_smanob.xml | sort | uniq -c 
  34             <t pos="adv">ikke</t>
  34             <t pos="adv">inte</t>
==> no need for it here

 ==> done and tested

10 --> 4) dette er en ny feature, bare hvis du har tid og det er enkelt å ordne:
 - constructing the single test file for this issue ==> done

 ==> done and tested

sortere ordformene i miniparadigmet alfabetisk

f.eks. rööpses

sg.nom  			reepses rööpses rååpsehke
komp. sg. nom	ruepsebe rååpsehkåbpoe
superl. sg. nom	rööpsemes rååpsehkommes


Dermed vil man få fram en bedre logikk mellom de forskjellige variantene.

Glemte en ting:

11 --> 5) I miniparadigmet for verb ønsker vi +PrfPrc med under neg, men før ger.   Taggen skal være: perf.  og i parantes (lea)

 ==> creating test files done

 ==> done and tested

f.eks. vaedtsedh:

neg. (ij) vaedtsieh
perf.  (lea) vaadtseme
verbgen. vaedtsien


12 --> 6) For PrfPrc ønsker vi ellers å endre tagen fra part. perf.   til perf. part.
 ==> done and tested

f.eks. vaedtsedh:

neg. (ij) vaedtsieh
perf.  (lea) vaadtseme
ger. (dïhte lea) vaedtsieminie
verbgen. vaedtsien

 ===> ask for clarification: done, it is about the presentation of analysis of a
      specific word form; the miniparadigm should have only "perf." as label

13 --> 6) Kanskje det heller ikke behøver å stå: (dïhte lea) vaedtsieminie i gerundium, bare: (lea) vaedtsieminie, dvs. samme som for perfektum.
 
Altså:
neg. (ij) vaedtsieh
perf.  (lea) vaadtseme
ger. (lea) vaedtsieminie
 ==> done and tested

14) compile the Stardict version of the smanob
   ==> problems with compiling dict with the old tools on Snow Leopard?
   
   ==> debug it: done!
The problem is now that Stardict doesn't like an extra dir within dic dir
as before. That means all files should be in the dic dir without intermediate
dirs.

 ==> first testing version done

Last minute wishes for StarDict:
 1sd. infinitive å marking
  ==> done and tested

 2sd. implement l_ref
  ==> done and tested

 3sd. I miniparadigmet for verb ønsker vi +PrfPrc med under neg, men før ger
.   Taggen skal være: perf.  og i parantes (lea)
 ==> done and tested

 4sd. For PrfPrc ønsker vi ellers å endre tagen fra part. perf.   til perf. 
part.
 ==> done and tested 

 5sd. Kanskje det heller ikke behøver å stå: (dïhte lea) vaedtsieminie i ger
undium, bare: (lea) vaedtsieminie, dvs. samme som for perfektum.

Altså:
neg. (ij) vaedtsieh
perf.  (lea) vaadtseme
ger. (lea) vaedtsieminie
 ==> done and tested

 6sd. implement illpl="no" Den skal fungere på samm
e måte som i smenob - at den ikke tar med flertallsform i miniparadigmet.
<l illpl="no" margo="e" pos="n" soggi="ie" stem="3syll">jemhkelde</l>
 ==> done and tested

 7sd. VGen
vi vil fjerne teksten i miniparadgimet (dïhte båata) og vi vil ha 'verbgen.' som
 tag istedenfor 'gen. v.'
 ==> done and tested


Last comments from Trond:


To ting:

1. presens er markert som "daenbiejjien". Dagens norm er "daan biejjien", dvs. 
(daan biejjien manne) vaadtsam
... etc.

Men forma "daenbiejjien" står i den viktigaste læreboka, så vi kan leve med det.

 ==> TODO

2. ø/ö-relax:

For macdict er ø-formene lagt inn som oppslag:

Både bööti (norm) og bøøti (brukt i Noreg)
viser til båetedh.

Dette er i macdict ordna med dobbelgenererering.

Det er fint å ha denne funksjonen, og til skilnad frå "daan biejjien" er det viktig.

 ==> TODO: to check and if possible to implement

3. update the webdict
 ==> TODO

