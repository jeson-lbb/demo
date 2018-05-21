#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-04-07 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is ssh-x-server install
############## 记录日志用的变量
Tik="\e[5m";Red="\e[31m";Grn="\e[32m";Ylw="\e[33m";Blu="\e[34m";Pup="\e[35m";Rst="\e[0m" 
FaShongDuan_Host_IP=${2}
Local_Rsync_Password=$(eval echo "~/remote_sh/Conf/rsync.password")
LocalHost_IP=`ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p'`
Time=$(date +%F\ %T)
Path_Intall_log_ok=~/Log/${Log_name}_Intall_ok.log
Path_Intall_log_false=~/Log/${Log_name}_Intall_false.log
############# 记录安装日志，并发送到客户端
Log_name=ssh-x-server
tftp_http_IP=$(/sbin/ifconfig eth1|awk -F "[ :]+" '/inet addr/{print $4}')
yum_IP=$(/sbin/ifconfig eth0|awk -F "[ :]+" '/inet addr/{print $4}')
mkdir -p /application/tar_xzf ~/Log /backup /server/{scripts,tools} /etc/yum.repos.d/repos.bak /Log_Backup
id rsync &>/dev/null || useradd -u 888 -s /sbin/nologin -M rsync 
sent_log(){
	if [ $? -eq ${RETVAL} ];then
	    echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ OK ] ${Time}">>${Path_Intall_log_ok}_${LocalHost_IP}
	else
	    echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ false ] ${Time}">>${Path_Intall_log_false}_${LocalHost_IP}
	fi
	rsync -az --password-file=${Local_Rsync_Password} \
	$(eval echo "~/Log") rsync-backup@${FaShongDuan_Host_IP}::Log_Backup
}
yum_cang_ku_install(){
	dir_rpm=/ssh-x-server/tools/yum.rpm
	mkdir -p /application/yum/centos6.9/x86.64/tar.gzs && cd /application/yum/centos6.9/x86.64/
	sum=0
	while (( ${sum} < 1 ))
	do
	    for n in $(ls ${dir_rpm}/*.rpm)
	    do
	        rpm -i $n
	    done
	    sum=$(rpm -qa createrepo |wc -l)
	done
# 安装web服务
	httpd=0
	while (( ${httpd} < 1 ))
	do
		for n in apr-util-ldap-1.3.9-3.el6_0.1.x86_64.rpm httpd-2.2.15-60.el6.centos.6.x86_64.rpm httpd-tools-2.2.15-60.el6.centos.6.x86_64.rpm
        do
            rpm -i /ssh-x-server/tools/server_rpms/$n
        done
        httpd=$(rpm -qa httpd |wc -l)
	done
	/bin/cp -ab /ssh-x-server/Kickstart/conf/httpd.conf /etc/httpd/conf/
	sed -ri "s#ServerAlias yum.etiantian.org#ServerAlias ${yum_IP}#g" /etc/httpd/conf/httpd.conf
	sed -ri "s#ServerAlias centos.etiantian.org#ServerAlias ${tftp_http_IP}#g" /etc/httpd/conf/httpd.conf
	/etc/init.d/httpd restart
	createrepo -pdo /application/yum/centos6.9/x86.64/ /application/yum/centos6.9/x86.64/
#	python -m SimpleHTTPServer 80 & &>/dev/null 
	/bin/mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/repos.bak
	/bin/cp -ab /ssh-x-server/conf/etiantian.repo /etc/yum.repos.d/
	/bin/cp -ab /ssh-x-server/tools/server_rpms/*.rpm /application/yum/centos6.9/x86.64/
	/bin/cp -ab /ssh-x-server/tools/tar.gzs/* /application/yum/centos6.9/x86.64/tar.gzs
	createrepo --update /application/yum/centos6.9/x86.64/
	RETVAL=$?
}
sys_ini(){
	cd /ssh-x-server/conf/ && /bin/cp -ab mail.rc hosts rsync.password rsyncd.conf rsync.ssh-x-server_daemon_password sudoers /etc/
/bin/cp -ab rc.local /etc/rc.d
	/bin/cp -ab etiantian.repo /etc/yum.repos.d/
	/bin/cp -ab root /var/spool/cron/
	/bin/cp -ab /ssh-x-server/scripts/cli_rsync_bak.sh /server/scripts/
	chown -R rsync.rsync /Log_Backup 
	rsync --daemon
	RETVAL=$?
}
sys_ini
sent_log
yum_cang_ku_install
sent_log
