#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-04-07 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is Backup-server install
############## 记录日志用的变量
FaShongDuan_Host_IP=${2}
Local_Rsync_Password=$(eval echo "/etc/rsync.Backup-server_sens_password")
LocalHost_IP=`ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p'`
Time=$(date +%F\ %T)
Log_name=Backup-server
Path_Intall_log_ok=~/Log/${Log_name}_Intall_ok.log
Path_Intall_log_false=~/Log/${Log_name}_Intall_false.log
############## 记录日志用的变量
id rsync &>/dev/null || useradd rsync -s /sbin/nologin -M
mkdir -p /application/tar_xzf ~/Log /backup /html /server/{scripts,tools} /etc/yum.repos.d/repos.bak
cd /Backup-server/conf/ && \
/bin/cp -ab hosts mail.rc rsyncd.conf rsync.password rsync.Backup-server_sent_password sudoers /etc/
/bin/cp -ab rc.local /etc/rc.d
/bin/cp -ab root /var/spool/cron/
/bin/mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/repos.bak
/bin/cp -ab etiantian.repo /etc/yum.repos.d/
cd /Backup-server/scripts && /bin/cp -ab rsync_bak.sh /server/scripts/
chown -R rsync.rsync /backup /html
rsync --daemon
RETVAL=$?
############# 记录安装日志，并发送到客户端
if [ 0 -eq ${RETVAL} ];then
    echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ OK ] ${Time}">>${Path_Intall_log_ok}_${LocalHost_IP}
else
    echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ false ] ${Time}">>${Path_Intall_log_false}_${LocalHost_IP}
fi
#rsync -az --password-file=${Local_Rsync_Password} $(eval echo "~/Log") rsync_backup@${FaShongDuan_Host_IP}::Log_Backup
