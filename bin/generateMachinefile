#!/bin/bash

# First erase all contents of the current Machinefile
cat /dev/null > Machinefile

# Then discover which machines are available and write the Machinefile
for i in {122..146}
do
  ping -c 1 131.114.73.$i
  
  if [ $? -eq 0 ]
    then echo 131.114.73.$i:`ssh 131.114.73.$i nproc` >> Machinefile;
  fi
done

