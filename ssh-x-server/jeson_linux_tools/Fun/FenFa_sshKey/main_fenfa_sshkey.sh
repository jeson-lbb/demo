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
path_FenFa_sshKey_conf=/ssh-x-server/jeson_linux_tools/Conf/FenFa_sshKey_conf/remote_users_ip_format.txt
path_FenFa_sshkey_true_log=/ssh-x-server/jeson_linux_tools/Log/FenFa_sshkey_log/FenFa_sshkey_true.log
path_FenFa_sshkey_false_log=/ssh-x-server/jeson_linux_tools/Log/FenFa_sshkey_log/FenFa_sshkey_false.log
path_FenFa_sshkey_true_false_log=/ssh-x-server/jeson_linux_tools/Log/FenFa_sshkey_log/FenFa_sshkey
path_FenFa_sshKey_exp=/ssh-x-server/jeson_linux_tools/Fun/FenFa_sshKey/fenfa_sshkey.exp
fenfa_sshkey(){
[ ! -s $path_FenFa_sshKey_conf ] && { echo -e "${Pup}${Tik}Warning:${Rst}\n    usage: [ $path_FenFa_sshKey_conf ]  is  empty!";return; }
expect_string=$(rpm -qa expect)
if [ -z $expect_string ];then
  if [ $UID -ne 0 ];then
        echo -e "${Pup}${Tik}Warning:${Rst}
    [ expect ] is not installed !
    Please usage < yum install expect -y > to install by [ root ] user ! "
	return 
  else
    echo -en "${Pup}${Tik}Warning:${Rst}\n    Please wait a moment ! \n   ${Grn}[ expect ] is installing......${Rst} [Press Crtl+C to exit]" 
 	yum install expect -y &>/dev/null
	expect_string=$(rpm -qa expect)
	[ -z $expect_string ] && { echo;return;}
	echo
        echo -e "expect verssion is : `rpm -qa expect` \n "
  fi
fi
[ ! -f ~/.ssh/id_dsa ] && { ssh-keygen -t dsa -q -P '' -f ~/.ssh/id_dsa>/dev/null ; }
echo -e "Path Is: [ $(echo ${path_FenFa_sshKey_conf}) ]"
echo -e "${Blu}Fen Fa Configuration Is:${Rst} "
cat $path_FenFa_sshKey_conf
echo -en "${Ylw}Are you sure you want to do ?${Rst}${Pup}[yes/no]${Rst}";read Choice_char
if [[ ${Choice_char} == "Y" || ${Choice_char} == "y" || ${Choice_char} == "yes" ]] ; then
  while read line
  do
	remote_user=$(echo $line|awk -F "[@ -]+" '{ print $1 }')
	remote_password=$(echo $line|awk -F "[@ -]+" '{ print $2 }')
	remote_ip=$(echo $line|awk -F "[@ -]+" '{ print $3 }')
   	expect $path_FenFa_sshKey_exp ~/.ssh/id_dsa.pub $remote_user $remote_password $remote_ip &>/dev/null
   if [ $? -eq 0 ];then	
		action "FenFa [~/.ssh/id_dsa.pub] to $remote_user@$remote_ip" true
		echo "FenFa [~/.ssh/id_dsa.pub] to $remote_user@$remote_ip  --- [ true ] $(date +%F\ %T)">>$path_FenFa_sshkey_true_log
  	 else
		action "FenFa [~/.ssh/id_dsa.pub] to $remote_user@$remote_ip" false
		echo "FenFa [~/.ssh/id_dsa.pub] to $remote_user@$remote_ip  --- [ false ] $(date +%F\ %T)">>$path_FenFa_sshkey_false_log
  	 fi
  done<$path_FenFa_sshKey_conf
  	echo -e "         ">>$path_FenFa_sshkey_true_log
  	echo -e "        ">>$path_FenFa_sshkey_false_log
	echo -e "${Ylw}Fe nFa files to each hosts is finished!\nLogs are in LocalHost:$Rst  [ `eval echo "${path_FenFa_sshkey_true_false_log}_[true/false].log" `]"
else
	echo -e "${Ylw}Fen Fa files to each hosts are canceled ! $Rst"
fi
echo -e "${Blu}============================================$Rst"
}
