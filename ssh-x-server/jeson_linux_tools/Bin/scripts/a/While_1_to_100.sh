#!/bin/bash
i=1
sum=0
while [ $i -le 100 ]
do
   echo -ne "$i+$sum=\e[35m$((sum+=i))\e[0m  "
   ((i++))
   sleep 0.05
done
