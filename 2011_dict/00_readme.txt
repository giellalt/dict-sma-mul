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

09.10.2011: @cip used the same settings as the last dict compilation.

2011_dict>wc -l missing_paradigm_* 
       2 missing_paradigm_a.txt
       7 missing_paradigm_n.txt
      22 missing_paradigm_prop.txt
       1 missing_paradigm_propPl.txt
       3 missing_paradigm_v.txt
      35 total





missing_paradigm_a.txt
======================

~/main/words/dicts/smanob$cat 2011_dict/missing_paradigm_a.txt |usmaNorm
gööles	gööles+1+A+Attr # pipeline
gööles	gööles+2+A+Attr

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
jåvle-eejehtalleme	jåvle-eejehtalleme+N+Sg+Nom  # hyphen for e-e
reakta-aamhtese	reakta-aamhtese+N+Sg+Nom  # hyphen for a-a
sliehtie-elmie	sliehtie-elmie+N+Sg+Nom # hyphen for e-e
tv-spïele	tv-spïele+N+Sg+Nom # hyphen problem

All these will be ok when we have a pipeline solution for hyphen.
There is a solution for hyphen in paradigm2xml_sma.pl
 63           if (!$dashedLemma) {
 64             $wordForm =~ s/\-//g;
 65           }
The problem seems to be some changes in an xsl-script: all value are generated and transformed
into xml correctly, however the restructuration does not work properly. Debugging it now.



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


All these will be ok when we have a pipeline solution for hyphen.


missing_paradigm_propPl.txt
===========================

Gaelpienjaevrieh

Look into this. Wrong lemma?


missing_paradigm_v.txt
======================

~/main/words/dicts/smanob/2011_dict$cat missing_paradigm_v.txt |usmaNorm

doksedh	doksedh+2+V+IV+Inf
doksedh	doksedh+1+V+TV+Inf

govledh	govledh+2+V+IV+Inf
govledh	govledh+1+V+TV+Inf 
 
svijredh	svijredh+2+V+IV+Inf
svijredh	svijredh+1+V+IV+Inf

This seems a +1 / +2 pipeline problem, + one missing
