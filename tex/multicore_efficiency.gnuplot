set terminal latex
set output "tex/multicore_efficiency.tex"
set boxwidth 0.5
set style fill solid
set yr [0:1.25]
plot "tex/multicore_efficiency.dat" using 2:xtic(1) title '$\epsilon(n)$' with boxes
unset output
