#!/bin/bash

for((i=10,n=1;n<=10;i--,n++))
do
for((aa=1;aa<=$i;aa++));do echo -n "a"|sed 's/.*/ /';sleep 0.05;done
for((aa=1;aa<=$n;aa++));do echo -n "b ";sleep 0.05;done
for((aa=1;aa<=$i;aa++));do echo -n "c "|sed 's/.*/ /';sleep 0.05;done
for((aa=1;aa<=$i;aa++));do echo -n "d"|sed 's/.*/ /';sleep 0.05;done
for((aa=1;aa<=$n;aa++));do echo -n "e ";sleep 0.05;done;echo ""
done 
