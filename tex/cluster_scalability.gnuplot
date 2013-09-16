set terminal latex
set output "tex/cluster_scalability.tex"
set boxwidth 0.5
set style fill solid
set yr [0:50]
plot "tex/cluster_scalability.dat" using 2:xtic(1) title '$\text{scalab}(n)$' with boxes
unset output
