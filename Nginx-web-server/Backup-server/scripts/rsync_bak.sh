#!/bin/bash
# Date:   01:17 2018-04-07 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is nfs install
############## 
>/backup/check_buckup.log
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
LocalHost=$(ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p')
Time=$(date +%F_%a)
mkdir -p /backup/${LocalHost}/${Time} && cd /backup/${LocalHost}/${Time} \
&& tar -czf $(hostname)_tar.gz /html /var/spool/cron/root /etc/{mail.rc,rc.d/rc.local,hosts,sysctl.conf,ssh/sshd_config} \
&& md5sum $(hostname)_tar.gz >$(hostname)_tar.gz.md5 \
&& sleep 600 \
&& find /backup/ -type d -mtime +3 -name "*-*-*_*" ! -name "*-*-*_Sat"|xargs /bin/rm -fr
for IP in $(ls /backup)
do
		cd /backup/$IP/$Time
		md5sum -c *_tar.gz.md5 &>/dev/null
		if [ $? -eq 0 ];then
			echo -e "$(hostname):${LocalHost} => /backup\n   >  Check   /backup/$IP/$Time   is   [ OK ]" >>/backup/check_buckup.log
		else
			echo -e "$(hostname):${LocalHost} => /backup\n   >  Check   /backup/$IP/$Time   is   [ false ]" >>/backup/check_buckup.log
		fi
done
mail -s "$(hostname) check backup messages " 1270963692@qq.com</backup/check_buckup.log
