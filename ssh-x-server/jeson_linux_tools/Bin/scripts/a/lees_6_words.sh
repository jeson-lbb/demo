#!/bin/bash
i="I am oldboy teacher welcome to oldboy training class."
for n in `echo "$i"`
do 
    if [ "${#n}" -le "6" ];then
	if [ `echo "$n"|grep "o"`&>/dev/null ];then
	echo "$n"
	fi
    fi
done
