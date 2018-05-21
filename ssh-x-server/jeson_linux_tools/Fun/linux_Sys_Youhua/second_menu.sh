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
path_Chkconfig_Set_menu=/ssh-x-server/jeson_linux_tools/Fun/linux_Sys_Youhua/Chkconfig_Set/Chkconfig_Set_menu.sh
source ${path_Chkconfig_Set_menu}
path_SELinux_Set_menu=/ssh-x-server/jeson_linux_tools/Fun/linux_Sys_Youhua/SELinux_Set/SELinux_Set_menu.sh
source ${path_SELinux_Set_menu}
path_Kernel_sysctl=/ssh-x-server/jeson_linux_tools/Fun/linux_Sys_Youhua/Kernel_sysctl/Kernel_sysctl_menu.sh
source ${path_Kernel_sysctl}
path_sshd_YouHua=/ssh-x-server/jeson_linux_tools/Fun/linux_Sys_Youhua/sshd_YouHua/sshd_YouHua_menu.sh
source ${path_sshd_YouHua}
second_menu(){
  echo -ne "Path: Linux System You Hua
   -------------${Ylw}MEMU OPTIONS${Rst}-------------
   ${Ylw}1) ${Rst}Chkconfig Set
   ${Ylw}2) ${Rst}SELinux Set
   ${Ylw}3) ${Rst}Sysctl Kernel
   ${Ylw}4) ${Rst}Sshd You Hua
   ${Ylw}5) ${Rst}Back UP Memu
   ${Ylw}0) ${Rst}Quit
${Blu}Please enter your choice[0-5]:${Rst}" 
  read second_num
  case "$second_num" in
      1)
	     clear
    	 sys_info
	 	 Chkconfig_Set_menu
      	;;
      2)
      	clear
      	sys_info
	  	SELinux_Set_menu
      	;;
      3)
      	clear
      	sys_info
      	Kernel_sysctl_menu
      	;;
      4)
      	clear
      	sys_info
	  	sshd_YouHua_menu
      	;;  
      5)
      	clear
      	main
      	;;
      0)exit 2
      	;;
      *)
      	clear
      	echo -e "\t  ${Tik}${Pup}You input error!$Rst"
      	sys_info
      	second_menu
  esac
}
