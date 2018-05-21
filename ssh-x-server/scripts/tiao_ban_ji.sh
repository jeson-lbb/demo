#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-04-07 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is nfs install
############## 记录日志用的变量
Tik="\e[5m";Red="\e[31m";Grn="\e[32m";Ylw="\e[33m";Blu="\e[34m";Pup="\e[35m";Rst="\e[0m" 
Local_Rsync_Password=$(eval echo "~/remote_sh/Conf/rsync.password")
LocalHost_IP=`ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p'`
Time=$(date +%F\ %T)
function trapper(){
	trap ':' INT EXIT TSTP TERM HUP
}
while true
do
	trapper
	clear
	cat <<menu
  1) 10.0.0.31 Nginx-LB01-server
  2) 10.0.0.32 Nginx-LB02-server
  3) 10.0.0.33 Nginx-web-server
  4) 10.0.0.34 Apache-web-server
  5) 10.0.0.35 MySQL-server
  6) 10.0.0.36 Nfs-server
  7) 10.0.0.37 Backup-server
  8) 10.0.0.38 ssh-x-server
  0) exit
menu
	read -p "Please select:" num
		case "$num" in
			1) ssh -P22 $USER@Nginx-LB01-server
			;;
			2) ssh -P22 $USER@Nginx-LB02-server
			;;
			3) ssh -P22 $USER@Nginx-web-server
			;;
			4) ssh -P22 $USER@Apache-web-server
			;;
			5) ssh -P22 $USER@MySQL-server
			;;
			6) ssh -P22 $USER@Nfs-server
			;;
			7) ssh -P22 $USER@Backup-server
			;;
			8) ssh -P22 $USER@ssh-x-server
			;;
			# 这里调用分发密匙脚本
			22) bash /ssh-x-server/scripts/main_fenfa_sshkey.sh
			;;
			0) exit
		esac
done
