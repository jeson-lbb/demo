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
path_set_chkconfig_on=/ssh-x-server/jeson_linux_tools/Conf/linux_Sys_Youhua_conf/set_chkconfig_on.conf
Chkconfig_Set_menu(){
  echo -ne "Path: Linux System You Hua > Chkconfig Set
   -------------${Ylw}MEMU OPTIONS${Rst}-------------
   ${Ylw}1) ${Rst}Chkconfig 3:on
   ${Ylw}2) ${Rst}Chkconfig all 
   ${Ylw}3) ${Rst}Chkconfig Set Only Serves on
   ${Ylw}4) ${Rst}>>> You Hua To Remote Each Hosts <<<
   ${Ylw}5) ${Rst}>>> Recovery To Remote Each Hosts <<<
   ${Ylw}6) ${Rst}Back UP Menu
   ${Ylw}7) ${Rst}Back First Memu
   ${Ylw}0) ${Rst}Quit
${Blu}Please enter your choice[0-7]:${Rst}" 
  read second_num
  case "$second_num" in
      1)
      	clear
	  	sys_info
      	chkconfig --list|grep "3:on"
        echo -e "${Blu}============================================$Rst"
      	Chkconfig_Set_menu
      	;;
      2)
      	clear
      	sys_info
      	chkconfig --list
      	echo -e "${Blu}============================================$Rst"
      	Chkconfig_Set_menu
      	;;
      3)
		clear
        sys_info
		echo -ne "${Pup}Warning:$Rst\nPath configure in: [ $( eval echo ${path_set_chkconfig_on}) ]\n`cat ${path_set_chkconfig_on}`\n"
		echo -en "${Ylw}Are you sure you want to do ?${Rst}${Pup}[yes/no]${Rst}";read Choice_char
   if [[ ${Choice_char} == "Y" || ${Choice_char} == "y" ||  ${Choice_char} == "yes" ]] ;then
      for chk_off_name in `chkconfig --list|awk '{print $1}'`
      do
		 chkconfig  "$chk_off_name" off
      done
      for chk_on_name in `cat ${path_set_chkconfig_on}`
      do
		 chkconfig  "$chk_on_name" on
      done
         chkconfig --list|grep "3:on"
		echo -e "${Ylw}Set chkconfig are finished ! $Rst"
	else
		echo -e "${Ylw}Set chkconfig are canceled ! $Rst"
   fi
        echo -e "${Blu}============================================$Rst"
        Chkconfig_Set_menu
      ;;
      4)
        clear
        source /ssh-x-server/jeson_linux_tools/local_sh/FenFa_Remote_Hosts.sh
        sys_info
        FenFa_Remote_Hosts "`eval echo ${Path_Remote_Users_IPs_conf}`" "chkconfig" "bash /ssh-x-server/jeson_linux_tools/remote_sh/Remote_Chkconfig_Set.sh"
        Chkconfig_Set_menu
      ;;
      5)
        clear
        sys_info
        source /ssh-x-server/jeson_linux_tools/local_sh/FenFa_Remote_Hosts.sh 
        FenFa_Remote_Hosts "`eval echo ${Path_Remote_Users_IPs_conf}`" "chkconfig" "bash /ssh-x-server/jeson_linux_tools/remote_sh/Remote_Chkconfig_Set.sh" "Recovery"
        Chkconfig_Set_menu
      ;;
      6)
	    clear	
		sys_info
        second_menu
      ;;
	  7)main
		;;
      0)exit 2
      ;;
      *)
      clear
      echo -e "\t  ${Tik}${Pup}You input error!$Rst"
      sys_info
      Chkconfig_Set_menu
  esac
}
