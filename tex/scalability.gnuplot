set terminal latex
set output "tex/scalability.tex"
set boxwidth 0.5
set style fill solid
set yr [0:7.5]
plot "tex/scalability.dat" using 2:xtic(1) title '$\text{scalab}(n)$' with boxes
unset output
