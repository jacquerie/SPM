    { jobs[$1] += $2; time[$1] += $3 }
END { for (i = 5; i <= 80; i += 5) {
        printf("%d %.2f\n", i, (1.49 * jobs[i]) / (time[i] * i))
      }
    }
