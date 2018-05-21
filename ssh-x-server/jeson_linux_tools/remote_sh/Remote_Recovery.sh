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
Remote_Set_Project=${1}
FaShongDuan_Host_IP=${2}
Local_Reload_CMD=${3}
Remote_Reload_Opt=${4}
DEST_File_Name=$(basename $Remote_Set_Project)
Path_Recovery_log_ok=/ssh-x-server/Log/${DEST_File_Name}_Recovery_ok.log
Path_Recovery_log_false=/ssh-x-server/Log/${DEST_File_Name}_Recovery_false.log
Local_Rsync_Password=$(eval echo "/ssh-x-server/remote_sh/Conf/rsync.password")
LocalHost_IP=`ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p'`
Time=$(date +%F\ %T)
Local_Recovery_File=$(ls -t1 ${Remote_Set_Project}.bak.${LocalHost_IP}|head -n 1)
sudo rsync -az ${Remote_Set_Project}.bak.${LocalHost_IP}/${Local_Recovery_File} ${Remote_Set_Project}
   if [ $? -eq 0 ];then
		eval `echo "${Local_Reload_CMD} ${Remote_Reload_Opt}"`
   			if [ $? -eq 0 ];then
   			echo "Remote Recovery And [ ${Remote_Set_Project} ] ${Local_Reload_CMD} ${Remote_Reload_Opt} to $USER@$LocalHost_IP  --- [ OK ] ${Time}">>${Path_Recovery_log_ok}_${LocalHost_IP}
   			else
        		echo "[ ${Remote_Set_Project} ] ${Local_Reload_CMD} ${Remote_Reload_Opt} to $USER@$LocalHost_IP  --- [ false ] ${Time}">>${Path_Recovery_log_false}_${LocalHost_IP}
   			fi
   else
        echo "Remote Recovery [ ${Remote_Set_Project} ] to $USER@$LocalHost_IP  --- [ false ] ${Time}">>${Path_Recovery_log_false}_${LocalHost_IP}
   fi
rsync -az --password-file=${Local_Rsync_Password} $(eval echo "/ssh-x-server/Log") rsync_Log_Backup@${FaShongDuan_Host_IP}::Log_Backup
