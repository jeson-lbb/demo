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
path_Kernel_sysctl=/ssh-x-server/jeson_linux_tools/Conf/linux_Sys_Youhua_conf/sysctl.conf
path_remote_backup_recovery_ip_conf=/ssh-x-server/jeson_linux_tools/Conf/remote_recovery/remote_backup_recovery_ip.conf
Kernel_sysctl_menu(){
  echo -ne "Path: Linux System You Hua > Sysctl Kernel
   -------------${Ylw}MEMU OPTIONS${Rst}-------------
   ${Ylw}1) ${Rst}Check /etc/sysctl.conf
   ${Ylw}2) ${Rst}You Hua sysctl.conf
   ${Ylw}3) ${Rst}>>> You Hua To Remote Each Hosts <<<
   ${Ylw}4) ${Rst}>>> Recovery To Remote Each Hosts <<<
   ${Ylw}5) ${Rst}Back UP Memu
   ${Ylw}6) ${Rst}Back First Memu
   ${Ylw}0) ${Rst}Quit
${Blu}Please enter your choice[0-6]:${Rst}" 
  read second_num
  case "$second_num" in
      1)
        clear
        sys_info
	    cat /etc/sysctl.conf
	    echo -e "${Blu}============================================$Rst"
	    Kernel_sysctl_menu
      ;;
      2)
  		if [[ "$(grep -o "###sysctl.conf###" /etc/sysctl.conf)" == "###sysctl.conf###" ]] ; then
			clear
        	sys_info
	    	echo -e "${Pup}${Tik}Warning:${Rst}\n     ${Ylw}[/etc/sysctl.conf] Already You Hua. ${Rst}"
  		else
			clear
        	sys_info
			echo -e "${Ylw}Path Configure :${Rst} [ ${path_Kernel_sysctl} ]"
        	cat $path_Kernel_sysctl
        	echo -en "${Pup}${Tik}Warning:${Rst}\n${Ylw}Are you sure you want to do ?${Rst}${Pup}[yes/no]${Rst}"
			read Choice_char
	 		if [[ ${Choice_char} == "Y" || ${Choice_char} == "y" || ${Choice_char} == "yes" ]] ; then
	    		rsync -az /etc/sysctl.conf{,.$(date +%F_\%T)}
	     		while read line
	     		do
		    		echo $line>>/etc/sysctl.conf
	     		done<$path_Kernel_sysctl
	     		sysctl -p 
				echo -e "${Ylw}FenFa files to each hosts is finished ! $Rst"
			else
				echo -e "${Ylw}Fen Fa files to each hosts are canceled ! $Rst"
  	 		fi
  		fi
	    	echo -e "${Blu}============================================$Rst"
        	Kernel_sysctl_menu
      ;;
      3)
        clear
        source /ssh-x-server/jeson_linux_tools/local_sh/FenFa_Remote_Hosts.sh
        sys_info
	    FenFa_Remote_Hosts `eval echo ${Path_Remote_Users_IPs_conf}` "/etc/sysctl.conf" "bash /ssh-x-server/jeson_linux_tools/remote_sh/Remote_YouHua_Backup.sh" "sysctl" "-p"
		Kernel_sysctl_menu
      ;;
      4)
        clear
        sys_info
        source /ssh-x-server/jeson_linux_tools/local_sh/FenFa_Remote_Hosts.sh
        FenFa_Remote_Hosts `eval echo ${Path_Remote_Users_IPs_conf}` "/etc/sysctl.conf" "bash /ssh-x-server/jeson_linux_tools/remote_sh/Remote_Recovery.sh" "sysctl" "-p"
		Kernel_sysctl_menu
      ;;
      5)
        clear
        sys_info
		second_menu	
      ;;
      6)main
		;;
      0)exit 2
      ;;
      *)
        clear
        echo -e "\t  ${Tik}${Pup}You input error!$Rst"
        sys_info
        Kernel_sysctl_menu
  esac
}
