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
 ==> todo

5) te-elementene uten parantes, bare i italics
 ==> done

6) pgv manglende v1,v2 i pipeline endringer i miniparadigmer:
   inkludere N+Sg+Nom, Pron+Indef+Sg+Nom og V+Inf
 ==> todo

