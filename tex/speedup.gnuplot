set terminal latex
set output "tex/speedup.tex"
set boxwidth 0.5
set style fill solid
set yr [0:9]
plot "tex/speedup.dat" using 2:xtic(1) title '$s(n)$' with boxes
unset output
