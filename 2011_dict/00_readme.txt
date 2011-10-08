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

jearsoe	jearsoe	+? # is an adj jearsoes, removed from dict and (earlier from) fst.

paagke	paagke	+? # sub for paahke, changed in dict

reakta-aamhtese	reakta-aamhtese+N+Sg+Nom  # hyphen for a-a

sliehtie-elmie	sliehtie-elmie+N+Sg+Nom # hyphen for e-e

traktore	traktovre+v1+N+Sg+Nom +v1 processing problem

tv-spïele	tv-spïele+N+Sg+Nom # hyphen problem




missing_paradigm_v.txt
======================

~/main/words/dicts/smanob/2011_dict$cat missing_paradigm_v.txt |usmaNorm

doksedh	doksedh+2+V+IV+Inf
doksedh	doksedh+1+V+TV+Inf

govledh	govledh+2+V+IV+Inf
govledh	govledh+1+V+TV+Inf

sjilhketidh	sjilhketidh	+? # not in LMM

svijredh	svijredh+2+V+IV+Inf
svijredh	svijredh+1+V+IV+Inf

This seems a +1 / +2 pipeline problem, + one missing