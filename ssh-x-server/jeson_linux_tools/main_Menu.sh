#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-03-24 
# Author: Created by jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is Linux tools main
#	   
### BEGIN INIT INFO
# 
# 
### END INIT INFO
. /etc/init.d/functions 
Tik="\e[5m";Red="\e[31m";Grn="\e[32m";Ylw="\e[33m";Blu="\e[34m";Pup="\e[35m";Rst="\e[0m"       
sys_info(){
	echo -e "${Blu}============================================$Rst 
   -----------${Ylw}System Information${Rst}---------
   ${Ylw}USER      :${Rst}$USER
   ${Ylw}HOSTNAME  :${Rst}$HOSTNAME
   ${Ylw}LOCATION  :${Rst}`pwd`
   ${Ylw}DISK_USED :${Rst}`df -h|awk -F "[ ]+" '/sda3/{print $5,$NF}' `
   ${Ylw}IP        :${Rst}`ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p'`
   ${Ylw}DATE      :${Rst}`date +%Y-%m-%d\ %H:%M:%S`
${Blu}============================================$Rst"
}
main_menu(){
  echo -ne "   -----------${Ylw}MAIN MEMU OPTIONS${Rst}----------
   ${Ylw}1) ${Rst}Fen Fa SshKey
   ${Ylw}2) ${Rst}Linux System You Hua
   ${Ylw}3) ${Rst}httpd Install
   ${Ylw}4) ${Rst}Nginx Install
   ${Ylw}5) ${Rst}MySQL Install
   ${Ylw}6) ${Rst}php Install
   ${Ylw}0) ${Rst}Quit
${Blu}Please enter your choice[0-6]:${Rst}" 
  read main_num
  case "$main_num" in
      1)
		clear 
		source /ssh-x-server/jeson_linux_tools/Fun/FenFa_sshKey/sshkey_second_menu.sh
	  	sys_info
	  	sshkey_second_menu
	  	;;
	  2)
	  	clear 
	  	source /ssh-x-server/jeson_linux_tools/Fun/linux_Sys_Youhua/second_menu.sh
	  	sys_info
	  	second_menu
	  	;;
	  3)
	  	clear 
	  	source /ssh-x-server/jeson_linux_tools/Fun/Server_Install_second_menu/http_second_menu.sh
	  	sys_info
		http_second_menu
	 	;;
	  4)
	  	clear 
	  	source /ssh-x-server/jeson_linux_tools/Fun/Server_Install_second_menu/Nginx_second_menu.sh
	  	sys_info
		Nginx_second_menu
	 	;;
	  5)
	  	clear 
	  	source /ssh-x-server/jeson_linux_tools/Fun/Server_Install_second_menu/MySQL_second_menu.sh
	  	sys_info
		MySQL_second_menu
	 	;;
	  6)
	  	clear 
	  	source /ssh-x-server/jeson_linux_tools/Fun/Server_Install_second_menu/php_second_menu.sh
	  	sys_info
		php_second_menu
	 	;;
	  0) exit 1
	  	;;
	  *)
	  	clear
	  	echo -e "\t  ${Tik}${Pup}You input error!$Rst"
	  	sys_info
	  	main_menu
  esac
}

main(){
	 clear
	 sys_info
     main_menu
}
main
