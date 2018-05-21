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
source /ssh-x-server/jeson_linux_tools/Fun/FenFa_sshKey/main_fenfa_sshkey.sh 
source /ssh-x-server/jeson_linux_tools/Fun/linux_Sys_Youhua/second_menu.sh 
sshkey_second_menu(){
  echo -ne "Path: Fen Fa SshKey
   -------------${Ylw}MEMU OPTIONS${Rst}-------------
   ${Ylw}1) ${Rst}>>> Fen Fa SshKey To Remote Hosts <<< 
   ${Ylw}2) ${Rst}Check Fen Fa SshKey True Log
   ${Ylw}3) ${Rst}Check Fen Fa SshKey False Log
   ${Ylw}4) ${Rst}>>> Fen Fa Files To Remote Each Hosts <<<
   ${Ylw}5) ${Rst}Back UP Memu
   ${Ylw}0) ${Rst}Quit
${Blu}Please enter your choice[0-5]:${Rst}" 
  read second_num
  case "$second_num" in
      1)
      	clear
      	sys_info
		fenfa_sshkey
		sshkey_second_menu
       ;;
      2)
      	clear
        sys_info
		echo -e "${Ylw}The FenFa sshKey true log is:\n[ $(echo ${path_FenFa_sshkey_true_log}) ]${Rst}"
		cat ${path_FenFa_sshkey_true_log}
		echo -e "${Blu}============================================$Rst"
        sshkey_second_menu
      	;;
      3)
      	clear
        sys_info
        echo -e "${Ylw}The FenFa sshKey false log is:\n[ $(echo ${path_FenFa_sshkey_false_log}) ]${Rst}"
		cat ${path_FenFa_sshkey_false_log}
		echo -e "${Blu}============================================$Rst"
        sshkey_second_menu
      	;;
      4)
        clear
        sys_info
        source /ssh-x-server/jeson_linux_tools/local_sh/FenFa_Remote_Hosts.sh
        FenFa_Remote_Hosts `eval echo ${Path_Remote_Users_IPs_conf}` "/ssh-x-server/remote_sh"
        sshkey_second_menu
      ;;
      5)
      	main
      	;;
      0)exit 2
      	;;
      *)
      clear
      echo -e "\t  ${Tik}${Pup}You input error!$Rst"
      sys_info
      sshkey_second_menu
  esac
}
