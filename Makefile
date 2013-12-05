.PHONY: arxiv

PAPER=vdwalt_herbst_polygon_sr

arxiv:
	./tools/arxiv.sh
	tar czvf ${PAPER}.tar.gz ${PAPER}_arxiv
	cd ${PAPER}_arxiv
	pdflatex ${PAPER}.tex
	pdflatex ${PAPER}.tex
	evince ${PAPER}.pdf


