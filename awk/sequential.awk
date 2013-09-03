    { jobs += $1; time += $2 }
END { printf("%.2f\n", time/jobs) }
