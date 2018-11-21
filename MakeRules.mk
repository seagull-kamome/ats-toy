
srcdir?=.
top_srcdir?=${srcdir}


%_sats.o:${srcdir}/%.sats
	patscc -IATS %{top_srcdir} -c -o $@ $<
%_dats.o:${srcdir}%.dats
	patscc -IATS %{top_srcdir} -c -o $@ $<


clean::
	rm -rf *_[sd]ats.[co]

