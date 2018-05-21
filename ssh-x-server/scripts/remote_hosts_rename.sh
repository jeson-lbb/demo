#!/bin/bash
# Date:   01:17 2018-02-24 
# Author: Created by leeth
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is 
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
while read line
do
   	Remote_HostName=$(echo $line|awk 'NF>2{print $2}')
   	Remote_HostIP=$(echo $line|awk 'NF>2{print $1}')
 	[[ $Remote_HostIP == "127.0.0.1" || $Remote_HostIP == "::1" ]] ||{
   		ssh root@$Remote_HostIP sed -ri "s#HOSTNAME=.*#HOSTNAME=$Remote_HostName#g" /etc/sysconfig/network & 
   		ssh root@$Remote_HostIP hostname $Remote_HostName &
	}
done</etc/hosts
