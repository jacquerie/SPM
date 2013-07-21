all: parallel sequential

clean:
	rm -f sequential parallel
	rm -f relazione.aux relazione.log relazione.pdf relazione.pyg relazione.toc

gif:
	convert -delay 1 -loop 0 "img/lena-threshold-*.png" lena.gif

parallel: src/parallel.cpp
	sketocxx src/parallel.cpp src/job.cpp -o parallel `Magick++-config --cppflags --cxxflags` -lMagick++ -lMagickCore

sequential: src/sequential.cpp
	g++ src/sequential.cpp src/job.cpp -o sequential `Magick++-config --cppflags --cxxflags` -lMagick++ -lMagickCore

tex:
	pdflatex -shell-escape tex/relazione.tex

.PHONY: all clean gif parallel sequential tex
