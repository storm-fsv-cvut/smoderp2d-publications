FILE=smoderp2d_foss4g_2019

default:
	pdflatex $(FILE)
	bibtex $(FILE)
	pdflatex $(FILE)
	pdflatex $(FILE)

clean:
	rm -f *.log *.aux *~

distclean:
	make clean
	rm -f $(FILE).pdf
