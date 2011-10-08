Paradigm generation with an FST borrowed from Lene
resulted in empty generation for the lemmata listed in these files.
Please check and if needed correct the fst and/or the source files.

08.10.2011: @cip used the same settings as the last dict compilation.

no-paradigm>wc -l * 
       3 missing_paradigm_a.txt
      10 missing_paradigm_n.txt
       1 missing_paradigm_pron.txt
      43 missing_paradigm_prop.txt
       1 missing_paradigm_propPl.txt
       4 missing_paradigm_v.txt
      62 total



missing_paradigm_a.txt
======================

~/main/words/dicts/smanob$cat 2011_dict/missing_paradigm_a.txt |usmaNorm
gööles	gööles+1+A+Attr # pipeline
gööles	gööles+2+A+Attr

ovnuvhtege	ovnuvhtege	+? # Commented out in fst:
!ovnuvhtege+CmpN/SgN+CmpN/SgG+CmpN/PlG:ovnuvhteg Ce_CE_ODDNOCOMP ;                                       
Check why with someone.
LA: jeg vet ikke hvorfor den er kommentert ut. ordet finnes ikke i LMM. Jeg kommenterer det inn igjen.

övtebe	övtebe	+? # This is in itself a comparative form, gives this analysis:
~/main/gt/sma/src$usmaNorm
evtebe
evtebe	evtebe+A+Comp+Attr
evtebe	evtebe+A+Comp+Sg+Nom
It is in the present dict as Comp only. If it causes trouble for the pipeline we might consider it as Adv, it is used as both.


missing_paradigm_n.txt
======================

~/main/words/dicts/smanob/2011_dict$cat missing_paradigm_n.txt |usmaNorm

dajveektievoete	dajve-ektievoete+N+Sg+Nom # hyphen for e-e
e-påaste	e-påaste+N+Sg+Nom
giesie-eejehtimmie	giesie-eejehtimmie+N+Sg+Nom # hyphen for e-e
jearsoe	jearsoe	+? # is an adj jearsoes, removed from dict and (earlier from) fst.
jåvle-eejehtalleme	jåvle-eejehtalleme+N+Sg+Nom  # hyphen for e-e
paagke	paagke	+? # sub for paahke, changed in dict
reakta-aamhtese	reakta-aamhtese+N+Sg+Nom  # hyphen for a-a
sliehtie-elmie	sliehtie-elmie+N+Sg+Nom # hyphen for e-e
traktore	traktovre+N+Sg+Nom # ok when  +v1 deletion works
tv-spïele	tv-spïele+N+Sg+Nom # hyphen problem




missing_paradigm_pron.txt
=========================

~/main/words/dicts/smanob$cat 2011_dict/missing_paradigm_pron.txt |usmaNorm
mijgih	mij+Pron+Rel+Sg+Nom+Foc/gih
mijgih	mij+Pron+Interr+Sg+Nom+Foc/gih

src/pronIndef_smanob.xml:         <l pos="pron" type="indef">mijgih</l>

Todo her (sannsynlegvis): Å leggje til mijgih som lemma, etter mönster av sme mihkkege.

LA:
Her burde det være laga en statisk fil med bøyninger, men jeg har for denne ordboka gjort slik:
lagt til pg="no" til mijgih
lagt til maamgih som nytt lemma med pg="no"



missing_paradigm_prop.txt
=========================

# ord som er lånt frå sme, som ein del av Oahpa-arbeidet.
# Framlegg:
# Vi fjerner dei internasjononale, og legg til dei frå Troms og
# Finnmark i fst-en.

# LA: jeg legger til pg="no" til de nordsamiske navnene, dvs at de ikke legges til i fst. Å legge til i fst er ikke helt problemfritt, kanskje vi skal ta det opp under Rørosmøtet.

# TT: Det er ein god strategi. pg="no" i ordboka, og ikkje i fst.

Disse har fått pg="no":
Giron			Giron		+?
Gáivuotna		Gáivuotna	+?
Kárášjohka		Kárášjohka	+?
Leavdnja		Leavdnja	+?
Porsángu		Porsángu	+?
Unjárga			Unjárga		+?



Følgende har jeg korrigert, og der er i fst:

Australija Australija	+?  => Austraalia
Beallohkslitnje		Beallohkslitnje	+?  => Beallohkslïtnje
Bovtselitnje		Bovtselitnje	+?  => Bovtselïtnje
Indonesija		Indonesija	+?  => Indoneesia
Jiengelesvaajja		Jiengelesvaajja	+?  => Jïengelesvaajja
Slovenije		Slovenije	+?  => Sloveenia
Snjiptje		Snjiptje	+?  => Snjïptje
Viermejaevrie		Viermejaevrie	+?  => Vïermejaevrie
Viermejohke		Viermejohke	+?  => Vïermejohke
Viermetjahke		Viermetjahke	+?  => Vïermetjahke
Vinhtsdurrienjaevrie	Vinhtsdurrienjaevrie	+?  => Vïnhtsdurrienjaevrie
Heedmarhke		Heedmarhke	+?   ==> Hedmarhke


# TT: Input til testen min var ikkje mine eigne ordboksfiler, 
# men filene frå Cip i denne katalogen, som eg testa mot usmaNorm.

# ikkje norm, dei har eg fjerna frå dict, TT
# mm, desse tre endringane hadde eg ikkje sjekka inn, men no er det ok.

Geeneve	Geeneve	     +?  => Geneve  fjerner denne LA
Kaalifornija	     Kaalifornija	+?  => Kalifornia
Kaanada		     Kaanada		+?  => Canada, dvs æ styker den



# Ord med bindestrek, dette er eit pipeline-problem:

Åarjel-Afrika	      Åarjel-Afrika+N+Prop+Plc+Sg+Nom
Åarjel-Balhkohkejaevrie	Åarjel-Balhkohkejaevrie+N+Prop+Plc+Sg+Nom
Åarjel-Tröndelaage	Åarjel-Tröndelaage+N+Prop+Plc+Sg+Nom
Bijjie-Gaajsjaevrie	Bijjie-Gaajsjaevrie+N+Prop+Plc+Sg+Nom
Bijjie-Neessanjaevrie	Bijjie-Neessanjaevrie+N+Prop+Plc+Sg+Nom
Bijjie-Sipmehke		Bijjie-Sipmehke+N+Prop+Plc+Sg+Nom
Bijjie-Trompenjaevrie	Bijjie-Trompenjaevrie+N+Prop+Plc+Sg+Nom
Gaske-Neessanjaevrie	Gaske-Neessanjaevrie+N+Prop+Plc+Sg+Nom
Jillie-Dåvnere		Jillie-Dåvnere+N+Prop+Plc+Sg+Nom
Jillie-Dearka		Jillie-Dearka+N+Prop+Plc+Sg+Nom
Jillie-Raajhkere	Jillie-Raajhkere+N+Prop+Plc+Sg+Nom
Jillie-Vuallerejaevrie	Jillie-Vuallerejaevrie+N+Prop+Plc+Sg+Nom
Luvlie-Balhkohke	Luvlie-Balhkohke+N+Prop+Plc+Sg+Nom
Luvlie-Raajhkere	Luvlie-Raajhkere+N+Prop+Plc+Sg+Nom
Luvlie-Sjeavrije	Luvlie-Sjeavrije+N+Prop+Plc+Sg+Nom
Luvlie-Vuallerejaevrie	Luvlie-Vuallerejaevrie+N+Prop+Plc+Sg+Nom
Noerhte-Trööndelage	Noerhte-Trööndelage+N+Prop+Plc+Sg+Nom
Onne-Giebnie		Onne-Giebnie+N+Prop+Plc+Sg+Nom
Skaanja-Stoerrevaerie	Skaanja-Stoerrevaerie+N+Prop+Plc+Sg+Nom
Vuelie-Neessanjaevrie	Vuelie-Neessanjaevrie+N+Prop+Plc+Sg+Nom
Vuelie-Sipmehke		Vuelie-Sipmehke+N+Prop+Plc+Sg+Nom
Vuelie-Trompenjaevrie	Vuelie-Trompenjaevrie+N+Prop+Plc+Sg+Nom





missing_paradigm_v.txt
======================

~/main/words/dicts/smanob/2011_dict$cat missing_paradigm_v.txt |usmaNorm

doksedh	doksedh+2+V+IV+Inf
doksedh	doksedh+1+V+TV+Inf

govledh	govledh+2+V+IV+Inf
govledh	govledh+1+V+TV+Inf

sjilhketidh	sjilhketidh	+? # not in LMM (Lass Mich Machen? Diese Computerlinguisten mit ihren Abkürzungen...)   LMM = Laila Mattson Maggas ordbok
 
svijredh	svijredh+2+V+IV+Inf
svijredh	svijredh+1+V+IV+Inf

This seems a +1 / +2 pipeline problem, + one missing
