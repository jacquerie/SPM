    { jobs[$1] += $2; time[$1] += $3 }
END { for (i = 5; i <= 80; i += 5) {
        printf("%d %.1f\n", i, (time[1] / jobs[1]) *  (jobs[i] / time[i]))
      }
    }
