#!/bin/bash
echo stu{01..2}|tr " " "\n"|sed -r 's#(.*)#useradd \1;pa=`echo ${RANDOM}|md5sum|cut -c 2-8`;echo ${pa}|passwd --stdin \1;echo -e "\1\t`echo ${pa}`">>/home/pass_pa#g'|bash
