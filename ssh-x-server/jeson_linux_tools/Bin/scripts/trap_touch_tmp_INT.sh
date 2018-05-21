#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-04-07 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is nfs install
while :
do
	trap "find /tmp/ -type f -name 'oldboy*.txt' -delete && exit" INT
	touch /tmp/oldboy_$(date +%F_%T).txt
	sleep 0.5
done
