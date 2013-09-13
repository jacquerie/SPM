set terminal latex
set output "tex/cluster_speedup.tex"
set boxwidth 0.5
set style fill solid
set yr [0:50]
plot "tex/cluster_speedup.dat" using 2:xtic(1) title '$s(n)$' with boxes
unset output
