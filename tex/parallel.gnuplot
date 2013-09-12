set terminal latex
set output "tex/parallel.tex"
set boxwidth 0.5
set style fill solid
set yr [0:1]
plot "tex/parallel.dat" using 2:xtic(1) title '$T_{\text{par}}(n)$' with boxes
unset output
