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
. /etc/init.d/functions
Path_Remote_Users_IPs_conf=/ssh-x-server/jeson_linux_tools/Conf/remote_recovery/Remote_Rsers_IPs.conf
MySQL_second_menu(){
  echo -ne "Path: MySQL Install
   -------------${Ylw}MEMU OPTIONS${Rst}-------------
   ${Ylw}1) ${Rst}MySQL_5.5.49 Note
   ${Ylw}2) ${Rst}Install MySQL_5.5.49 At Localhost
   ${Ylw}3) ${Rst}>>> Install MySQL_5.5.49 At Remote Hosts <<<
   ${Ylw}4) ${Rst}Back UP Memu
   ${Ylw}0) ${Rst}Quit
${Blu}Please enter your choice[0-4]:${Rst}" 
  read choice_num
  case "$choice_num" in
      1)
	    clear
    	sys_info
        echo -e "${Grn}$(grep ".*" /ssh-x-server/jeson_linux_tools/remote_sh/Server_Install/mysql_5.5.49_install.sh)${Rst}
${Blu}============================================$Rst" 
		MySQL_second_menu
    	;;
      2)
      	clear
      	sys_info
		bash /ssh-x-server/jeson_linux_tools/remote_sh/Server_Install/mysql_5.5.49_install.sh
		if [ $? -eq 0 ] ;then
			action "Install MySQL_5.5.49 At Localhost" true
		else
		    action "Install MySQL_5.5.49 At Localhost" false
		fi
        echo -e "${Blu}============================================$Rst" 
		MySQL_second_menu
      	;;
      3)
      	clear
      	sys_info
        source /ssh-x-server/jeson_linux_tools/local_sh/FenFa_Remote_Hosts.sh
       	FenFa_Remote_Hosts `eval echo ${Path_Remote_Users_IPs_conf}` "/ssh-x-server/remote_sh" "bash /ssh-x-server/jeson_linux_tools/remote_sh/Server_Install/mysql_5.5.49_install.sh"
		MySQL_second_menu
      	;;  
      4)
      	clear
      	main
      	;;
      0)exit 2
      	;;
      *)
      	clear
      	echo -e "\t  ${Tik}${Pup}You input error!$Rst"
      	sys_info
      	MySQL_second_menu
  esac
}
