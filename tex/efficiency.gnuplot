set terminal latex
set output "efficiency.tex"
set boxwidth 0.5
set style fill solid
set yr [0:1]
plot "efficiency.dat" using 2:xtic(1) title '$\epsilon(n)$' with boxes
unset output
