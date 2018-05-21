#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-02-24 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is local tong yong de fen fa Interface
#	   
### BEGIN INIT INFO
# 
# 
### END INIT INFO
Path_FenFa_Files_true_log=/ssh-x-server/jeson_linux_tools/Log/FenFa_files_log/FenFa_Files_true.log
Path_FenFa_Files_false_log=/ssh-x-server/jeson_linux_tools/Log/FenFa_files_log/FenFa_Files_false.log
Path_FenFa_Files_true_false_log=/ssh-x-server/jeson_linux_tools/Log/FenFa_files_log/FenFa_files
Path_rsyncd_conf=/ssh-x-server/jeson_linux_tools/Conf/Rsync_conf/rsyncd.conf
Path_rsync_password=/ssh-x-server/jeson_linux_tools/Conf/Rsync_conf/rsync.password
Path_Remote_You_Hua_config_Dir=/ssh-x-server/jeson_linux_tools/remote_sh/
FenFa_Remote_Hosts(){
	Path_Remote_Users_IPs_conf=${1}
	Path_Remote_DEST_Files=$(eval echo ${2})
	Remote_Exe_Script=${3}
	Remote_Reload_CMD=${4}
	Remote_Reload_Opt=${5}
    Time=$(date +%F_\%T)
	DEST_File_Name=$(basename ${Path_Remote_DEST_Files})
	Path_Remote_You_Hua_config=$(find ${Path_Remote_You_Hua_config_Dir} -type f -name "*${DEST_File_Name}*")
	Local_IP=$(ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p')
	Rsync_User=$(grep "^rsync" /etc/passwd)
	if [ -z ${Rsync_User} ];then
		useradd -M -s /sbin/nologin rsync
	fi
	mkdir /Log_Backup/Backup -p
	mkdir /Log_Backup/Log -p
	chown -R rsync.rsync /Log_Backup
	rsync -az ${Path_rsyncd_conf} ${Path_rsync_password} /etc/
	[ -z "$(ps -ef |grep '[r]sync')" ] && { pkill rsync ; rsync --daemon ; } 
	echo -en "${Ylw}Path Remote Users IPs conf: $Rst\n[ ${Path_Remote_Users_IPs_conf} ]
$(cat ${Path_Remote_Users_IPs_conf})${Ylw}\nPath Remote DEST Files: $Rst[ ${Path_Remote_DEST_Files} ]
${Ylw}Remote Reload CMD:$Rst      [ ${Remote_Reload_CMD} ${Remote_Reload_Opt} ]
${Ylw}Path Remote You Hua Config:$Rst$Rst${Pup}  注意：备份时，以下参数不准确；带完善中。。。${Rst}
[ ${Path_Remote_You_Hua_config} ]${Ylw}Show it:$Rst${Pup}[ yes/no ]${Rst}"
  read Choice_Char
  if [[ ${Choice_Char} == "Y" || ${Choice_Char} == "y" || ${Choice_Char} == "yes" ]] ; then
		cat ${Path_Remote_You_Hua_config}
  fi
echo -e "${Blu}>>> Usage Rsync --daemon to receive remote log <<<$Rst\n${Ylw}Path rsyncd.conf:$Rst       [ ${Path_rsyncd_conf} ]\n$(cat ${Path_rsyncd_conf})
${Ylw}Path rsync.password:$Rst    [ ${Path_rsync_password} ]\n$(cat ${Path_rsync_password})"
	echo -en "${Ylw}Fen Fa Remote Hosts ?${Rst}${Pup}   [yes/no]${Rst}"
  read Choice_Char
  if [[ ${Choice_Char} == "Y" || ${Choice_Char} == "y" || ${Choice_Char} == "yes" ]] ; then
    	while read line
    	do
    	    Remote_User=$(echo $line|awk -F "[@ -]+" '{ print $1 }')
        	Remote_IP=$(echo $line|awk -F "[@ -]+" '{ print $2 }')
 			if [ -n "$(eval echo ${Remote_Exe_Script})" ];then
#### ${Remote_Exe_Script} is not null ########################################################################
   				ssh ${Remote_User}@${Remote_IP} ${Remote_Exe_Script}\
 ${Path_Remote_DEST_Files} ${Local_IP} ${Remote_Reload_CMD} ${Remote_Reload_Opt} &>/dev/null & 
			fi
 			if [ -z "$(eval echo ${Remote_Exe_Script})" ];then
######## ${Remote_Exe_Script} is null ########################################################################
				rsync -az ${Path_Remote_DEST_Files} ${Remote_User}@${Remote_IP}:~
				RETVAL=$?
 				if [ ${RETVAL} -eq 0 ];then
            		 echo "Fen Fa ${Path_Remote_DEST_Files} to $Remote_User@$Remote_IP  --- [ true ] ${Time}">>$Path_FenFa_Files_true_log
        		else
            		echo "Fen Fa ${Path_Remote_DEST_Files} to $Remote_User@$Remote_IP  --- [ false ] ${Time}">>$Path_FenFa_Files_false_log
        		fi
			fi
    	done<$Path_Remote_Users_IPs_conf
 			if [ -n "$(eval echo ${Remote_Exe_Script})" ];then
  					echo -e "${Ylw}Fen Fa Remote Hosts Are Finished!\nLogs Are In LocalHost:$Rst  [ /Log_Backup/Log/${DEST_File_Name}.[true/false].log_IP ]"
  					echo -e "${Ylw}Fen Fa Remote Hosts Are Finished!\nRemot Buckups Are In LocalHost:$Rst  [ /Log_Backup/Backup/${DEST_File_Name}.bak.IP ]"
			else
        			echo -e "${Ylw}Fen Fa Files To Each Hosts Is Finished!\nLogs Are In LocalHost:$Rst  [ ${Path_FenFa_Files_true_false_log}_[true/false].log ]"
			fi
  else
		echo -e "${Ylw}Fen Fa Remote Hosts Are Canceled ! $Rst" 
  fi
  echo -e "${Blu}============================================$Rst"
}
