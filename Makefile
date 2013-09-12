MAGICFLAGS = `Magick++-config --cppflags --cxxflags --ldflags --libs`

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
	awk -f awk/multicore_service_time.awk dat/parallel_multicore.raw > tex/parallel.dat
	awk -f awk/multicore_efficiency.awk dat/parallel_multicore.raw > tex/efficiency.dat
	awk -f awk/multicore_scalability.awk dat/parallel_multicore.raw > tex/scalability.dat
	awk -f awk/multicore_speedup.awk dat/parallel_multicore.raw > tex/speedup.dat
	gnuplot tex/parallel.gnuplot
	gnuplot tex/efficiency.gnuplot
	gnuplot tex/scalability.gnuplot
	gnuplot tex/speedup.gnuplot
	pdflatex -shell-escape tex/relazione.tex

sequential: src/sequential.cpp
	g++ src/sequential.cpp src/job.cpp -o bin/sequential $(MAGICFLAGS)

.PHONY: clean gif nproc parallel pdf sequential

