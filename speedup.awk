    { jobs[$1] += $2; time[$1] += $3 }
END { for (i = 1; i <= 16; i += 1) {
        printf("%d %.2f\n", i, 0.86 * jobs[i] / time[i])
      }
    }
