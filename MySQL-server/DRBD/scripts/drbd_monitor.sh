#!/bin/bash
# Date:   01:17 2018-02-24 
# Author: Created by jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is MySQL_DRBD Startus Check
#	   
Tik="\e[5m";Red="\e[31m";Grn="\e[32m";Ylw="\e[33m";Blu="\e[34m";Pup="\e[35m";Rst="\e[0m"
# ro status two value
role=($(drbdadm role all|tr "/" "\n"))
# ds status two value
dstate=($(drbdadm dstate all|tr "/" "\n"))
# cs status one value
cstate=$(drbdadm cstate all)

if [ "Primary" == ${role[0]} -a "Secondary" == ${role[1]} -a \
"UpToDate" == ${dstate[0]} -a "UpToDate" == ${dstate[1]} -a \
"Connected" == $cstate ] ;then
	echo -e "${Grn}MySQL_DRBD Startus is OK !${Rst}"
	exit 0
else
	echo -e "${Ylw}MySQL_DRBD Startus is FALSE !${Rst}"
	exit 2
fi
