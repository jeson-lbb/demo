#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-02-24 
# Author: Created by leeth
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is 
#	   
### BEGIN INIT INFO
# 
# 
### END INIT INFO
SELinux_Set_menu(){
  echo -ne "Path: Linux System You Hua > SELinux Set
   -------------${Ylw}MEMU OPTIONS${Rst}-------------
   ${Ylw}1) ${Rst}SELinux Check
   ${Ylw}2) ${Rst}Set SELinux on
   ${Ylw}3) ${Rst}Set SELinux off 
   ${Ylw}4) ${Rst}Back UP Menu
   ${Ylw}5) ${Rst}Back First Memu
   ${Ylw}0) ${Rst}Quit
${Blu}Please enter your choice[0-4]:${Rst}" 
  read second_num
  case "$second_num" in
      1)
      	clear
      	sys_info
		echo -e "$(grep "^SELINUX=" /etc/selinux/config)\ngetenforce $(getenforce)"
		echo -e "${Blu}============================================$Rst"
	  	SELinux_Set_menu
      	;;
      2)
      	clear
      	sys_info
 	  if [ $(grep "^SELINUX=" /etc/selinux/config) == "SELINUX=disabled" ];then
	     sed -i 's#SELINUX=disabled#SELINUX=enforcing#' /etc/selinux/config
	     [ $(getenforce) == "Disabled" -o $(getenforce) == "Permissive" ] && { setenforce 1 &>/dev/null ; }
	  fi
      	echo -e "$(grep "^SELINUX=" /etc/selinux/config)\ngetenforce $(getenforce)"
	  	[ $(getenforce) == "Disabled" ] && { echo -e "${Pup}${Tik}Warning:${Rst}\n    SELinux [Enforcing] must reboot by Linux." ; }
	  	echo -e "${Blu}============================================$Rst"
      	SELinux_Set_menu
      	;;
      3)
        clear
      	sys_info
      if [ $(grep "^SELINUX=" /etc/selinux/config) == "SELINUX=enforcing" ];then
         sed -i 's#SELINUX=enforcing#SELINUX=disabled#' /etc/selinux/config
         [ $(getenforce) == "Enforcing" ] && { setenforce 0 ; }
      fi     
      	echo -e "$(grep "^SELINUX=" /etc/selinux/config)\ngetenforce $(getenforce)"
	  	echo -e "${Blu}============================================$Rst"
      	SELinux_Set_menu
      	;;
      4)
      	clear
      	sys_info
      	second_menu
      	;;
      5)main
		;;
      0)exit 2
      	;;
      *)
      	clear
      	echo -e "\t  ${Tik}${Pup}You input error!$Rst"
      	sys_info
      	SELinux_Set_menu
  esac
}
