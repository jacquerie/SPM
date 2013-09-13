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
	awk -f awk/multicore_service_time.awk dat/parallel_multicore.raw > tex/multicore_service_time.dat
	awk -f awk/multicore_efficiency.awk dat/parallel_multicore.raw > tex/multicore_efficiency.dat
	awk -f awk/multicore_scalability.awk dat/parallel_multicore.raw > tex/multicore_scalability.dat
	awk -f awk/multicore_speedup.awk dat/parallel_multicore.raw > tex/multicore_speedup.dat
	awk -f awk/cluster_service_time.awk dat/parallel_cluster.raw > tex/cluster_service_time.dat
	awk -f awk/cluster_efficiency.awk dat/parallel_cluster.raw > tex/cluster_efficiency.dat
	awk -f awk/cluster_scalability.awk dat/parallel_cluster.raw > tex/cluster_scalability.dat
	awk -f awk/cluster_speedup.awk dat/parallel_cluster.raw > tex/cluster_speedup.dat
	gnuplot tex/multicore_service_time.gnuplot
	gnuplot tex/multicore_efficiency.gnuplot
	gnuplot tex/multicore_scalability.gnuplot
	gnuplot tex/multicore_speedup.gnuplot
	gnuplot tex/cluster_service_time.gnuplot
	gnuplot tex/cluster_efficiency.gnuplot
	gnuplot tex/cluster_scalability.gnuplot
	gnuplot tex/cluster_speedup.gnuplot
	pdflatex -shell-escape tex/relazione.tex

sequential: src/sequential.cpp
	g++ src/sequential.cpp src/job.cpp -o bin/sequential $(MAGICFLAGS)

.PHONY: clean gif nproc parallel pdf sequential

