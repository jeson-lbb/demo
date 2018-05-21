#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-04-07 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is nginx-1.6.3.tar.gz install
############## 记录日志用的变量
FaShongDuan_Host_IP=${2}
Local_Rsync_Password=$(eval echo "/ssh-x-server/remote_sh/Conf/rsync.password")
LocalHost_IP=`ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p'`
Time=$(date +%F\ %T)
mkdir -p /ssh-x-server/Log

install_dir_tar_gz=/ssh-x-server/remote_sh/tools/nginx.tar.gz
Log_name=$(basename `find ${install_dir_tar_gz} -type f -name "nginx-1.6.3.tar.gz"`)

Path_Intall_log_ok=/ssh-x-server/Log/${Log_name}_Intall_ok.log
Path_Intall_log_false=/ssh-x-server/Log/${Log_name}_Intall_false.log
############## 记录日志用的变量

openssl_devel_dir_rpm=/ssh-x-server/remote_sh/tools/openssl-devel_rpm
mkdir -p /application/tar_xzf

rmp_sum=0
while (( ${rmp_sum} < 3 ))
do
    for n in $(ls ${openssl_devel_dir_rpm}/*.rpm)
    do
        rpm -i $n
    done
    rmp_sum=$(rpm -qa openssl-devel bzip2-devel pcre-devel |wc -l)
    echo -e "Have lib_devel sum [ 3 ] now: 3 - ${rmp_sum} = $((3-${rmp_sum}))"
done

# 显示本次装了3个rpm包依赖库
rpm -qa zlib-devel openssl-devel pcre-devel 
# 创建nginx用户
id nginx &>/dev/null
if [ $? -eq 1 ] ;then
   useradd -M -s /sbin/nologin nginx
fi
# 安装Nginx主程序
tar zxf $(find ${install_dir_tar_gz} -type f -name "nginx-1.6.3.tar.gz") -C /application/tar_xzf
cd /application/tar_xzf/nginx-1.6.3
./configure \
--prefix=/application/nginx-1.6.3 \
--user=nginx \
--group=nginx \
--with-http_stub_status_module \
--with-http_ssl_module \

make && make install
RETVAL=$?
[ -x /application/nginx ] && rm -fr /application/nginx
ln -s /application/nginx-1.6.3/ /application/nginx
# 启动nginx-1.6.3
/application/nginx/sbin/nginx -s stop
/application/nginx/sbin/nginx

############# 记录安装日志，并发送到客户端
if [ $? -eq ${RETVAL} ];then
	echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ OK ] ${Time}">>${Path_Intall_log_ok}_${LocalHost_IP}
else
    echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ false ] ${Time}">>${Path_Intall_log_false}_${LocalHost_IP}
fi
rsync -az --password-file=${Local_Rsync_Password} \
$(eval echo "/ssh-x-server/Log") rsync_Log_Backup@${FaShongDuan_Host_IP}::Log_Backup
