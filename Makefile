MAGICFLAGS = `Magick++-config --cppflags --cxxflags --ldflags --libs`

awk:
	awk -f awk/sequential.awk dat/multicore-sequential.dat
	awk -f awk/sequential.wak dat/cluster-sequential.dat

clean:
	rm -f bin/sequential bin/parallel
	rm -f relazione.aux relazione.log relazione.out relazione.pyg relazione.toc

gif:
	convert -delay 1 -loop 0 "img/lena-threshold-*.png" lena.gif

nproc:
	@awk -F ":" -f awk/nproc.awk Machinefile

parallel: src/parallel.cpp
	sketocxx src/parallel.cpp src/job.cpp -o bin/parallel $(MAGICFLAGS)

pdf:
	pdflatex -shell-escape tex/relazione.tex

sequential: src/sequential.cpp
	g++ src/sequential.cpp src/job.cpp -o bin/sequential $(MAGICFLAGS)


.PHONY: awk clean gif nproc parallel pdf sequential

