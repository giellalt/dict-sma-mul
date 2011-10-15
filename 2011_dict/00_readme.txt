Paradigm generation with an FST borrowed from Lene
resulted in empty generation for the lemmata listed in these files.
Please check and if needed correct the fst and/or the source files.

Alt er ok? Veldig <tysk bundeskanzlerin>ig!

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

 - constructing the single test file for this issue ==> todo

 ==> todo
 
 



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

 ==> todo


