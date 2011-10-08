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




missing_paradigm_v.txt

~/main/words/dicts/smanob/2011_dict$cat missing_paradigm_v.txt |usmaNorm

doksedh	doksedh+2+V+IV+Inf
doksedh	doksedh+1+V+TV+Inf

govledh	govledh+2+V+IV+Inf
govledh	govledh+1+V+TV+Inf

sjilhketidh	sjilhketidh	+? # not in LMM

svijredh	svijredh+2+V+IV+Inf
svijredh	svijredh+1+V+IV+Inf

This seems a +1 / +2 pipeline problem, + one missing