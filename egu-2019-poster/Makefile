latexfile = Landa_et_al_egu_2019

TEX = pdflatex
BIB = bibtex

all: clean
	$(TEX) $(latexfile)
	$(BIB) $(latexfile)
	$(TEX) $(latexfile)
	$(TEX) $(latexfile)
	$(TEX) $(latexfile)

view :
	okular $(latexfile).pdf &
clean: 
	rm -f  *.dvi *.bbl *.blg *.aux *.log *.spl *.out *.toc *.nav *.snm
public_html: 
	rsync -av $(latexfile).pdf ~/public_html/poster/
