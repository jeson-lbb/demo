#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-02-24 
# Author: Created by leeth
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is Remote YouHua And Backup 
#          
### BEGIN INIT INFO
# 
# 
### END INIT INFO
Remote_Set_Project=${1}
FaShongDuan_Host_IP=${2}
Reload_CMD=${3}
Reload_Opt=${4}
LocalHost_IP=`ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p'`
Time=$(date +%F_\%T)
DEST_File_Name=$(basename ${Remote_Set_Project})
Path_YouHua=$(find /ssh-x-server/remote_sh/Conf/ -type f -name "*${DEST_File_Name}*")
Local_Rsync_Password=$(eval echo "/ssh-x-server/remote_sh/Conf/rsync.password")
mkdir ${Remote_Set_Project}.bak.${LocalHost_IP} /ssh-x-server/Log -p
RENVAL=$?
if [[ $(grep -o "###${DEST_File_Name}###" "${Remote_Set_Project}" ) != "###${DEST_File_Name}###" && $RENVAL == 0 ]] ;then
		sshd_config_bakup="${Remote_Set_Project}.bak.${LocalHost_IP}/${DEST_File_Name}.$Time"
        eval sudo rsync -az ${Remote_Set_Project} ${sshd_config_bakup} 
		if [ $? -eq 0 ];then
			echo -e "${LocalHost_IP}  Backup [ $sshd_config_bakup ]\t     --- [ OK ] ${Time}">>/ssh-x-server/Log/${DEST_File_Name}.true.log_${LocalHost_IP}
		else
			echo -e "${LocalHost_IP}  Backup [ $sshd_config_bakup ]\t     --- [ false ] ${Time}">>/ssh-x-server/Log/${DEST_File_Name}.false.log_${LocalHost_IP}
		fi
    	while read line
    	do
            echo $line>>${Remote_Set_Project}
    	done<$Path_YouHua
		if [ $? -eq 0 ] ;then
			echo -e "${LocalHost_IP}  Update [ ${Remote_Set_Project} ]By[ ${Path_YouHua} ]--- [ OK ] ${Time}">>/ssh-x-server/Log/${DEST_File_Name}.true.log_${LocalHost_IP}
		else
			echo -e "${LocalHost_IP}  Update [ ${Remote_Set_Project} ]By[ ${Path_YouHua} ]--- [ false ] ${Time}">>/ssh-x-server/Log/${DEST_File_Name}.false.log_${LocalHost_IP}
			eval `echo "${Reload_CMD} ${Reload_Opt}"` 
		fi
		if [ $? -eq 0 ] ;then
			echo -e "${LocalHost_IP}  [${Remote_Set_Project}] [ ${Reload_CMD} ${Reload_Opt} ]  \t \t \t \t \t \t --- [ OK ] ${Time}">>/ssh-x-server/Log/${DEST_File_Name}.true.log_${LocalHost_IP}
		else
			echo -e "${LocalHost_IP}  [${Remote_Set_Project}] [ ${Reload_CMD} ${Reload_Opt} ]  \t \t \t \t \t \t --- [ false ] ${Time}">>/ssh-x-server/Log/${DEST_File_Name}.false.log_${LocalHost_IP}
		fi
else
    echo -e "${LocalHost_IP}  [ ${Remote_Set_Project} ]  It has been Updated and does not need to be Update  ${Time}">>\
/ssh-x-server/Log/${DEST_File_Name}.false.log_${LocalHost_IP}
fi
rsync -az --password-file=${Local_Rsync_Password} $(eval echo "/ssh-x-server/Log") rsync_Log_Backup@${FaShongDuan_Host_IP}::Log_Backup
rsync -az --password-file=${Local_Rsync_Password} $(eval echo "${Remote_Set_Project}.bak.${LocalHost_IP}") rsync_Log_Backup@${FaShongDuan_Host_IP}::Log_Backup/Backup
