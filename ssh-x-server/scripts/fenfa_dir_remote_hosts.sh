#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-04-07 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is nfs install
############## 记录日志用的变量
	Tik="\e[5m";Red="\e[31m";Grn="\e[32m";Ylw="\e[33m";Blu="\e[34m";Pup="\e[35m";Rst="\e[0m" 
	for n in `ls /servers` 
	do
		rsync -az /servers/$n root@$n:/
    	if [ $? -eq 0 ];then
			remot_IP=$(awk '/'$n'/{print $1}' /etc/hosts)
        	echo -e "fenfa dir [${Grn} $n ${Rst}] to ${Ylw}$USER${Rst}@${Ylw}$remot_IP${Rst}:/  --- [ ${Grn} OK ${Rst}]\n"
    	else
        	echo -e "fenfa dir [${Grn} $n ${Rst}] to ${Ylw}$USER${Rst}@${Ylw}$remot_IP${Rst}:/  --- [ ${Red} false ${Rst}]\n"
    	fi
	done
