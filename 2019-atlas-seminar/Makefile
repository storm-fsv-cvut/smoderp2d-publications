latexfile = prezentace
TEX = pdflatex
BIB = bibtex

all: 
	$(TEX) $(latexfile)
	#$(BIB) $(latexfile)
	$(TEX) $(latexfile)
	#$(TEX) $(latexfile)
	#$(TEX) $(latexfile)
	

view :
	okular $(latexfile).pdf &
clean: 
	rm -f  *.dvi *.bbl *.blg *.aux *.log *.spl *.out *.toc  *.bcf *.nav *.snm *.backup *.xml
up: 
	rsync -av $(latexfile).pdf /home/jakub/public_html/atlas-prezentace
	
