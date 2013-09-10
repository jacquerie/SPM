MAGICFLAGS = `Magick++-config --cppflags --cxxflags --ldflags --libs`

awk:
	awk -f awk/sequential.awk dat/sequential-multicore.dat
	awk -f awk/sequential.wak dat/sequential-cluster.dat

clean:
	rm -f bin/sequential bin/parallel
	rm -f relazione.aux relazione.log relazione.out relazione.pyg relazione.toc

gif:
	convert -delay 1 -loop 0 "img/lena-threshold-*.png" lena.gif

nproc:
	@awk -F ":" -f awk/nproc.awk Machinefile

parallel: src/parallel.cpp
	sketocxx src/parallel.cpp src/job.cpp -o bin/parallel $(MAGICFLAGS)

parallel_cluster:
	@bin/parallelCluster >> dat/parallel-cluster.dat

parallel_multicore:
	@bin/parallelMulticore >> dat/parallel-multicore.dat

pdf:
	pdflatex -shell-escape tex/relazione.tex

sequential: src/sequential.cpp
	g++ src/sequential.cpp src/job.cpp -o bin/sequential $(MAGICFLAGS)

sequential_cluster:
	@bin/sequentialCluster >> dat/sequential-cluster.dat

sequential_multicore:
	@bin/sequentialMulticore >> dat/sequential-multicore.dat

.PHONY: awk clean gif nproc parallel parallel_cluster parallel_multicore pdf sequential sequential_cluster sequential_multicore

