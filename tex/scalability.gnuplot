set terminal latex
set output "scalability.tex"
set boxwidth 0.5
set style fill solid
set yr [0:7.5]
plot "scalability.dat" using 2:xtic(1) title '$\text{scalab}(n)$' with boxes
unset output
