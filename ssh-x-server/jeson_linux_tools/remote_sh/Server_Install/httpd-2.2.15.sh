#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-04-07 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is httpd-2.2.15 install
############## 记录日志用的变量
FaShongDuan_Host_IP=${2}
Local_Rsync_Password=$(eval echo "/ssh-x-server/remote_sh/Conf/rsync.password")
LocalHost_IP=`ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p'`
Time=$(date +%F\ %T)
mkdir -p /ssh-x-server/Log

install_rpm=/ssh-x-server/remote_sh/tools/httpd-2.2.15
Log_name=httpd-2.2.15

Path_Intall_log_ok=/ssh-x-server/Log/${Log_name}_Intall_ok.log
Path_Intall_log_false=/ssh-x-server/Log/${Log_name}_Intall_false.log
############## 记录日志用的变量

rmp_sum=0
while (( ${rmp_sum} < 1 ))
do
    for n in $(ls ${install_rpm}/*.rpm)
    do
        rpm -i $n
    done
    rmp_sum=$(rpm -qa httpd|wc -l)
    echo -e "Have httpd sum [ 1 ] now: 1 - ${rmp_sum} = $((1-${rmp_sum}))"
done

# 显示本次装了1个rpm包依赖库
rpm -qa httpd
# 启动httpd-2.2.15
/etc/init.d/httpd restart
RETVAL=$?

#1 配置 httpd-2.2.15
#	/etc/httpd/conf/httpd.conf 
#	276:ServerName 127.0.0.1:80
#	990:NameVirtualHost *:80
#2.1 配置www站点：
#	1003:<VirtualHost *:80>
#	1004:    ServerAdmin 49000448-@qq.com 
#	1005:    DocumentRoot /var/html/www
#	1006:    ServerName www.etiantian.org
#	1007:    ErrorLog logs/www-error_log
#	1008:    CustomLog logs/www-access_log common
#	1009:</VirtualHost>
#2.2 配置bbs站点
#	1011:<VirtualHost *:80>
#	1012:    ServerAdmin 49000448-@qq.com
#	1013:    DocumentRoot /var/html/bbs
#	1014:    ServerName bbs.etiantian.org
#	1015:    ErrorLog logs/bbs-error_log
#	1016:    CustomLog logs/bbs-access_log common
#	1017:</VirtualHost>
#2.3配置blog站点：
#	1019:<VirtualHost *:80>
#	1020:    ServerAdmin 49000448-@qq.com
#	1021:    DocumentRoot /var/html/blog
#	1022:    ServerName blog.etiantian.org
#	1023:    ErrorLog logs/blog-error_log
#	1024:    CustomLog logs/blog-access_log common
#	1025:</VirtualHost>
#4 配置站点目录：
#	mkdir -p /var/html/{www,bbs,blog}
#	echo "bbs.etiantian.org">/var/html/bbs/index.html
#	echo "www.etiantian.org">/var/html/www/index.html
#	echo "blog.etiantian.org">/var/html/blog/index.html
#5 启动 httpd
#	/etc/init.d/httpd start
#6 测试 httpd
#	curl  bbs.etiantian.org
#	curl www.etiantian.org
#	curl  blog.etiantian.org

############# 记录安装日志，并发送到客户端
if [ $? -eq ${RETVAL} ];then
	echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ OK ] ${Time}">>${Path_Intall_log_ok}_${LocalHost_IP}
else
    echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ false ] ${Time}">>${Path_Intall_log_false}_${LocalHost_IP}
fi
rsync -az --password-file=${Local_Rsync_Password} \
$(eval echo "/ssh-x-server/Log") rsync_Log_Backup@${FaShongDuan_Host_IP}::Log_Backup
