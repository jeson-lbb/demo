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
path_sshd_YouHua=/ssh-x-server/jeson_linux_tools/Conf/linux_Sys_Youhua_conf/sshd_config
Path_Remote_Users_IPs_conf=/ssh-x-server/jeson_linux_tools/Conf/remote_recovery/Remote_Rsers_IPs.conf
sshd_YouHua_menu(){
  echo -ne "Path: Linux System You Hua > Sshd You Hua
   -------------${Ylw}MEMU OPTIONS${Rst}-------------
   ${Ylw}1) ${Rst}Check /etc/ssh/sshd_config 
   ${Ylw}2) ${Rst}Sshd You Hua Configuration
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
	    cat /etc/ssh/sshd_config 
        echo -e "${Blu}============================================$Rst"
	    sshd_YouHua_menu
      ;;
      2)
	  if [[ $(grep -o "###sshd_config###" /etc/ssh/sshd_config) == "###sshd_config###" ]] ; then
			clear
        	sys_info
	    	echo -e "${Pup}${Tik}Warning:${Rst}\n    ${Pup}[ /etc/ssh/sshd_config ] Already You Hua.${Rst}
${Blu}============================================$Rst"
	    	sshd_YouHua_menu
	  else
			clear
        	sys_info
      		echo -e "${Ylw}Path Configure :${Rst} [ ${path_sshd_YouHua} ]"
	     while read line
	     do
			echo -e "$line"
	     done<$path_sshd_YouHua
		   echo -en "${Ylw}Are you sure you want to do ?${Rst}${Pup}[yes/no]${Rst}";read Choice_char
		 if [[ ${Choice_char} == "Y" || ${Choice_char} == "y" || ${Choice_char} == "yes" ]] ; then
	         rsync -az /etc/ssh/sshd_config{,.$(date +%F_\%T)}
	         while read line
	         do
		  	     echo $line>>/etc/ssh/sshd_config
	         done<$path_sshd_YouHua
		     /etc/init.d/sshd reload
			 echo -e "${Ylw}FenFa files to each hosts is finished ! $Rst"
		else
			echo -e "${Ylw}Fen Fa files to each hosts are canceled ! $Rst"
		fi
		echo -e "${Blu}============================================$Rst"  
	    sshd_YouHua_menu
	  fi
      ;;
      3)
        clear
        source /ssh-x-server/jeson_linux_tools/local_sh/FenFa_Remote_Hosts.sh
        sys_info
        FenFa_Remote_Hosts `eval echo ${Path_Remote_Users_IPs_conf}` "/etc/ssh/sshd_config" "bash /ssh-x-server/jeson_linux_tools/remote_sh/Remote_YouHua_Backup.sh" "/etc/init.d/sshd" "reload" 
	    sshd_YouHua_menu
      ;;
      4)
        clear
        sys_info
        source /ssh-x-server/jeson_linux_tools/local_sh/FenFa_Remote_Hosts.sh 
        FenFa_Remote_Hosts `eval echo ${Path_Remote_Users_IPs_conf}` "/etc/ssh/sshd_config" "bash /ssh-x-server/jeson_linux_tools/remote_sh/Remote_Recovery.sh" "/etc/init.d/sshd" "reload"
	    sshd_YouHua_menu
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
        sshd_YouHua_menu
  esac
}
