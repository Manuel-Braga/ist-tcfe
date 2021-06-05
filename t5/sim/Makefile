all: ngspice1.log ngspice2.log 
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)

	$(eval NGSFIGS2=$(shell grep _FIG ngspice2.log | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS2=$(addsuffix .ps, $(NGSFIGS2)))
	$(eval NGSTABS2=$(shell grep _TAB ngspice2.log | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS2), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' ngspice2.log | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(foreach i, $(NGSFIGPS2), ps2pdf $i;)


ngspice1.log: t4.net
	ngspice -b $< -o $@                          

ngspice2.log: t4_out_imp.net
	ngspice -b $< -o $@                          

clean:
	@rm -f *.log *.tex *.pdf *.ps *.txt *~

.PHONY: all clean
