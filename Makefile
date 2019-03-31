latexfile = main

# TEX = pdflatex
# xetext je kvuli fontu
TEX = pdflatex
BIB = bibtex

all: 
	$(TEX) $(latexfile)
	$(BIB) $(latexfile)
	$(TEX) $(latexfile)
	$(TEX) $(latexfile)
	$(TEX) $(latexfile)

view :
	okular $(latexfile).pdf &
clean: 
	rm -f  *.dvi *.bbl *.blg *.aux *.log *.spl *.out *.toc 
