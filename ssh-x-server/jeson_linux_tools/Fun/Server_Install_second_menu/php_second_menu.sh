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
php_second_menu(){
  echo -ne "Path: php Install
   -------------${Ylw}MEMU OPTIONS${Rst}-------------
   ${Ylw}1) ${Rst}php Note php_5.3.27  
   ${Ylw}2) ${Rst}Install php_5.3.27 At Localhost
   ${Ylw}3) ${Rst}>>> Install php_5.3.27 At Remote Hosts <<<
   ${Ylw}4) ${Rst}php Note php_5.6.35  
   ${Ylw}5) ${Rst}Install php_5.6.35 At Localhost
   ${Ylw}6) ${Rst}>>> Install php_5.6.35 At Remote Hosts <<<
   ${Ylw}7) ${Rst}Back UP Memu
   ${Ylw}0) ${Rst}Quit
${Blu}Please enter your choice[0-7]:${Rst}" 
  read choice_num
  case "$choice_num" in
      1)
	    clear
    	sys_info
        echo -e "${Grn}$(grep ".*" /ssh-x-server/jeson_linux_tools/remote_sh/Server_Install/php_5.3.27_install.sh)${Rst}
${Blu}============================================$Rst" 
		php_second_menu
    	;;
      2)
      	clear
      	sys_info
		bash /ssh-x-server/jeson_linux_tools/remote_sh/Server_Install/php_5.3.27_install.sh
		if [ $? -eq 0 ] ;then
			action "Install php_5.3.27 At Localhost" true
		else
		    action "Install php_5.3.27 At Localhost" false
		fi
        echo -e "${Blu}============================================$Rst" 
		php_second_menu
      	;;
      3)
      	clear
      	sys_info
        source /ssh-x-server/jeson_linux_tools/local_sh/FenFa_Remote_Hosts.sh
       	FenFa_Remote_Hosts `eval echo ${Path_Remote_Users_IPs_conf}` "/ssh-x-server/remote_sh" "bash /ssh-x-server/jeson_linux_tools/remote_sh/Server_Install/php_5.3.27_install.sh"
		php_second_menu
      	;;  
      4)
	    clear
    	sys_info
        echo -e "${Grn}$(grep ".*" /ssh-x-server/jeson_linux_tools/remote_sh/Server_Install/php_5.6.35_install.sh)${Rst}
${Blu}============================================$Rst" 
		php_second_menu
    	;;
      5)
      	clear
      	sys_info
		bash /ssh-x-server/jeson_linux_tools/remote_sh/Server_Install/php_5.6.35_install.sh
		if [ $? -eq 0 ] ;then
			action "Install php_5.6.35 At Localhost" true
		else
		    action "Install php_5.6.35 At Localhost" false
		fi
        echo -e "${Blu}============================================$Rst" 
		php_second_menu
      	;;
      6)
      	clear
      	sys_info
        source /ssh-x-server/jeson_linux_tools/local_sh/FenFa_Remote_Hosts.sh
       	FenFa_Remote_Hosts `eval echo ${Path_Remote_Users_IPs_conf}` "/ssh-x-server/remote_sh" "bash /ssh-x-server/jeson_linux_tools/remote_sh/Server_Install/php_5.6.35_install.sh"
		php_second_menu
      	;;  
      7)
      	clear
      	main
      	;;
      0)exit 2
      	;;
      *)
      	clear
      	echo -e "\t  ${Tik}${Pup}You input error!$Rst"
      	sys_info
      	php_second_menu
  esac
}
