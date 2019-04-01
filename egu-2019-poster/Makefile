latexfile = main

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
	rm -f  *.dvi *.bbl *.blg *.aux *.log *.spl *.out *.toc 
