#!/bin/bash
for n in {11111..32768}
do
    sum=`echo ${n}|md5sum|cut -c 1-8`
    if [ "$*" == "$sum" ];then
       echo ${n}
	exit 10
    fi
#sleep 1
done
