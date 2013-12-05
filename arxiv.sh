#!/bin/bash

PAPER=vdwalt_herbst_polygon_sr
ARXIV=${PAPER}_arxiv
EXTRA="nips12submit_e.sty"

echo "Converting paper from LyX to tex..."
lyx -e pdflatex ${PAPER}.lyx

if ! grep pdfoutput ${PAPER}.tex > /dev/null; then
    echo "Add '\pdfoutput=1' in the document preamble first.  Aborting."
    exit -1
fi

echo "Scanning paper for images..."
IMAGES=`tools/tex_grep_fig.py ${PAPER}.tex`
TEX=`ls -1 *.tex`

echo "Compiling paper..."
pdflatex ${PAPER}.tex 1> /dev/null

echo "Compiling bibliography..."
for b in *.aux; do
    bibtex $b 1> /dev/null
done

BBL=`ls -1 *.bbl`

echo "Copying file to arXiv directory..."

rm -rf ${ARXIV}
mkdir -p ${ARXIV}/figures

for f in ${IMAGES}; do
    cp $f ${ARXIV}/$f
done

cp ${BIB} ${TEX} ${BBL} ${EXTRA} ${ARXIV}
