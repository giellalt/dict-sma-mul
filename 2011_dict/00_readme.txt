Paradigm generation with an FST borrowed from Lene
resulted in empty generation for the lemmata listed in these files.
Please check and if needed correct the fst and/or the source files.

Alt er ok? Veldig <tysk bundeskanzlerin>ig!

Issues to fix:

1) Nå fungerer linkingen i misc_stat_smanob.xml - men eksemplene er fremdeles ikke med

   <e>
      <lg>
         <l pos="pron" type="indef">maam akt</l>
         <lemma_ref lemmaID="mij akt_pron_indef">mij akt</lemma_ref>
         <analysis>Pron_Indef_Sg_Acc</analysis>
      </lg>
      <mg>
         <tg>
            <t pos="phrase" type="indef">et eller annet</t>
            <xg>
               <x>Mijjieh hov tjoeveribie maam akt darjodh.</x>
               <xt>Vi må jo gjøre et eller annet.</xt>
            </xg>
         </tg>
      </mg>
   </e>

2) Entryer som har lang="sme" i kildefila, får et tomt mg-element i den kompilerte ordboka, f.eks. gåeskie. baalhka er har to tomme mg-elementer!
åarjel

3) <te> elementet er ikke synlig (det var det samme problemet sist)


4) Jeg ser også at l_ref ikke er implementert, men det er en helt ny feature. Vi kan ta det i smenobVD. Det er uansett ikke så mange av dem i smadict

