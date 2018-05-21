#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-02-24 
# Author: Created by leeth
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is Chkconfig Set And Backup Recovery 
#	   
### BEGIN INIT INFO
# 
# 
Remote_Set_Project=${1}
FaShongDuan_Host_IP=${2}
Remote_Reload_CMD=${3}
LocalHost_IP=`ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p'`
Time=$(date +%F_\%T)
Chkconfig_Name=$(echo ${Remote_Set_Project}|awk '{print $1}') 
Local_Rsync_Password=$(eval echo "/ssh-x-server/remote_sh/Conf/rsync.password")
Rurrency_Chkconfig_Set(){
	for Chk_off_Name in `chkconfig --list|grep "3:on"|awk '{print $1}'`
    do
		 chkconfig  "$Chk_off_Name" off
    done
    for Chk_on_Name in `cat ${Path_Rurrency_Chkconfig_Conf}`
    do
		 chkconfig  "$Chk_on_Name" on
    done
	Update_Chkconfig_State=$?
}
Chkconfig_You_Hua_Log(){
	if [ ${Backup_Chkconfig_State} -eq 0 ] ;then
		echo -e "${LocalHost_IP}  Backup   [ ${Chkconfig_Name} ] To [${Path_Chkconfig_Buckup_Conf}]\t\t\t--- [ OK ] ${Time}">>/ssh-x-server/Log/${Chkconfig_Name}.true.log_${LocalHost_IP}
	else
		echo -e "${LocalHost_IP}  Backup   [ ${Chkconfig_Name} ] To [${Path_Chkconfig_Buckup_Conf}]\t\t\t--- [ false ] ${Time}">>/ssh-x-server/Log/${Chkconfig_Name}.false.log_${LocalHost_IP}
	fi
	if [ ${Update_Chkconfig_State} -eq 0 ] ;then
		echo -e "${LocalHost_IP}  Update   [ ${Chkconfig_Name} ] By [${Path_Rurrency_Chkconfig_Conf}]    --- [ OK ] ${Time}">>/ssh-x-server/Log/${Chkconfig_Name}.true.log_${LocalHost_IP} 
	else
		echo -e "${LocalHost_IP}  Update   [ ${Chkconfig_Name} ] By [${Path_Rurrency_Chkconfig_Conf}]    --- [ false ] ${Time}">>/ssh-x-server/Log/${Chkconfig_Name}.false.log_${LocalHost_IP}
	fi
}
Chkconfig_Recovery_Log(){
	if [ ${Update_Chkconfig_State} -eq 0 ] ;then
		echo -e "${LocalHost_IP}  Recovery [ ${Chkconfig_Name} ] By [${Path_Rurrency_Chkconfig_Conf}]\t\t\t--- [ OK ] ${Time}">>/ssh-x-server/Log/${Chkconfig_Name}.true.log_${LocalHost_IP} 
	else
		echo -e "${LocalHost_IP}  Recovery [ ${Chkconfig_Name} ] By [${Path_Rurrency_Chkconfig_Conf}]\t\t\t--- [ false ] ${Time}">>/ssh-x-server/Log/${Chkconfig_Name}.false.log_${LocalHost_IP}
	fi
}
if [ "${Remote_Reload_CMD}" == "Recovery" ] ;then
	Path_Chkconfig_Buckup_Conf=$(find /ssh-x-server/Backup/${Chkconfig_Name}.bak.${LocalHost_IP}/ -type f -name "*${Chkconfig_Name}*"|xargs ls -t1|head -n 1)
	Path_Rurrency_Chkconfig_Conf=${Path_Chkconfig_Buckup_Conf}
	Rurrency_Chkconfig_Set
	Chkconfig_Recovery_Log
else
	Path_Chkconfig_Set_Conf=$(find /ssh-x-server/remote_sh/Conf/ -type f -name "*${Chkconfig_Name}*")
	Path_Rurrency_Chkconfig_Conf=${Path_Chkconfig_Set_Conf}
	mkdir /ssh-x-server/Backup/${Chkconfig_Name}.bak.${LocalHost_IP}/ /ssh-x-server/Log  -p;Mkdir_State=$?
    echo $(chkconfig --list|grep "3:on"|awk '{print $1}')>/ssh-x-server/Backup/${Chkconfig_Name}.bak.${LocalHost_IP}/chkconfig.${Time};Backup_Chkconfig_State=$?
	Path_Chkconfig_Buckup_Conf=$(find /ssh-x-server/Backup/${Chkconfig_Name}.bak.${LocalHost_IP}/ -type f -name "*${Chkconfig_Name}*"|xargs ls -t1|head -n 1)
	if [[ ${Mkdir_State} == 0 && ${Backup_Chkconfig_State} == 0 ]] ;then
		Rurrency_Chkconfig_Set
		Chkconfig_You_Hua_Log
	fi
fi
rsync -az --password-file=${Local_Rsync_Password} $(eval echo "/ssh-x-server/Log") $(eval echo "/ssh-x-server/Backup") rsync_Log_Backup@${FaShongDuan_Host_IP}::Log_Backup
