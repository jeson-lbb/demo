#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-04-07 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is nfs install
############## 记录日志用的变量
Tik="\e[5m";Red="\e[31m";Grn="\e[32m";Ylw="\e[33m";Blu="\e[34m";Pup="\e[35m";Rst="\e[0m" 
FaShongDuan_Host_IP=${2}
Local_Rsync_Password=$(eval echo "/etc/rsync.password")
LocalHost_IP=`ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p'`
Time=$(date +%F\ %T)
Path_Intall_log_ok=~/Log/${Log_name}_Intall_ok.log
Path_Intall_log_false=~/Log/${Log_name}_Intall_false.log
############## 记录日志用的变量
mkdir -p /application/tar_xzf ~/Log /backup /html/{www/{swfupload,allimg},bbs/{image,avatar,forum},blog/uploads} \
# 创建nginx用户
id nginx &>/dev/null || useradd -u 888 -M -s /sbin/nologin nginx
/server/{scripts,tools} /etc/yum.repos.d/repos.bak
cd /Nfs-server/conf/ && \
/bin/cp -ab exports hosts mail.rc rsync.password sudoers /etc/
/bin/cp -ab rc.local /etc/rc.d
/bin/cp -ab root /var/spool/cron/
/bin/mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/repos.bak
/bin/cp -ab etiantian.repo /etc/yum.repos.d/
cd /Nfs-server/scripts && /bin/cp -ab inotifywait_html.sh cli_rsync_bak.sh /server/scripts/
nfs_install(){
Log_name=nfs
	yum -y install nfs-utils rpcbind 
	RETVAL=$?
		chkconfig rpcbind on
		chkconfig nfs on    
		/etc/init.d/rpcbind start 
		/etc/init.d/nfs start  
}
inotify_install(){
Log_name=inotify
	cd /server/scripts && wget http://yum.etiantian.org/tar.gzs/inotify-tools-3.14.tar.gz
	tar xzf /server/scripts/inotify-tools-3.14.tar.gz -C /application/tar_xzf/
	cd /application/tar_xzf/inotify-tools-3.14
	./configure
	make && make install
	RETVAL=$?
	chown -R nginx.nginx /html
}
############# 记录安装日志，并发送到客户端
rsync_backup(){
	if [ 0 -eq ${RETVAL} ];then
		echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ OK ] ${Time}">>${Path_Intall_log_ok}_${LocalHost_IP}
	else
	    echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ false ] ${Time}">>${Path_Intall_log_false}_${LocalHost_IP}
	fi
	rsync -az --password-file=${Local_Rsync_Password} $(eval echo "~/Log") rsync_backup@${FaShongDuan_Host_IP}::Log_Backup
}
nfs_install
rsync_backup
inotify_install
rsync_backup
source /etc/rc.local 
