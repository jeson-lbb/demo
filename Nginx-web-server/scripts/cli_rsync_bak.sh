#!/bin/bash
# Date:   01:17 2018-04-07 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is nfs install
############## 
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
LocalHost_IP=$(ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p')
Time=$(date +%F_%a)
Backup_server_IP=$(awk '/Backup-server/{print $1}' /etc/hosts)
mkdir -p /backup/${Time} && cd /backup/${Time} \
&& tar -czf $(hostname)_tar.gz /html /var/spool/cron/root /etc/{sudoers,mail.rc,rc.d/rc.local,hosts,sysctl.conf,ssh/sshd_config} \
&& md5sum $(hostname)_tar.gz >$(hostname)_tar.gz.md5 \
&& rsync -az --password-file=/etc/rsync.password /backup/ rsync_backup@Backup-server::backup/$LocalHost_IP \
&& find /backup/ -type d -mtime +2 -name "*-*-*_*"|xargs rm -fr 
   RETVAL=$?
if [ $? -eq ${RETVAL} ];then
	echo -e "LocalHost:  $(hostname):${LocalHost_IP}\n   >  rsync  $(hostname)_${Time}.tar.gz   to   ${Backup_server_IP}   [ OK ]"|mail -s "$(hostname) rsync" 1270963692@qq.com 
else
	echo -e "LocalHost:  $(hostname):${LocalHost_IP}\n   >  rsync  $(hostname)_${Time}.tar.gz   to   ${Backup_server_IP}   [ false ]"|mail -s "$(hostname) rsync" 1270963692@qq.com 
fi

