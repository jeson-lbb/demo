#!/bin/bash
sum=0
while read line
do
   echo "line=  $line"
   value=`echo $line|awk -F "" '{print $'$1'}'`
   expr $value + 1 &>/dev/null
   [ $? -ne 0 ]&&continue
   ((sum+=value))
   sleep 1
done</root/0.txt
echo $sum
