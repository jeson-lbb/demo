#!/bin/bash
#Date:   01:17 2018-01-24 
#Author: Created by leeth
#Mail:   309769163@qq.com
#Funcsion:This scripts funcsion is touch ten files in "/oldboy/" directory
#Version:1.1
Path="/oldboy/"
[ -d $Path ] || mkdir $Path  # Find "/oldboy/" directory (yes or no)
for n in `seq 10`
do 
  char=$(echo $RANDOM|md5sum|cut -c 2-11|tr "[0-9]" "[a-j]")
  touch "$Path""$char"_oldboy.html 
done
exit 45
