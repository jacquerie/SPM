MAGICFLAGS = `Magick++-config --cppflags --cxxflags --ldflags --libs`

all: gif parallel sequential tex

clean:
	rm -f sequential parallel
	rm -f relazione.aux relazione.log relazione.out relazione.pyg relazione.toc

gif:
	convert -delay 1 -loop 0 "img/lena-threshold-*.png" lena.gif

nproc:
	@awk -F ":" -f awk/nproc.awk Machinefile

parallel: src/parallel.cpp
	sketocxx src/parallel.cpp src/job.cpp -o parallel $(MAGICFLAGS)

sequential: src/sequential.cpp
	g++ src/sequential.cpp src/job.cpp -o sequential $(MAGICFLAGS)

tex:
	pdflatex -shell-escape tex/relazione.tex

.PHONY: all clean gif parallel sequential tex

