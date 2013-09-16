set terminal latex
set output "tex/multicore_service_time.tex"
set boxwidth 0.5
set style fill solid
set yr [0:1.25]
plot "tex/multicore_service_time.dat" using 2:xtic(1) title '$T_{\text{par}}(n)$' with boxes
unset output
