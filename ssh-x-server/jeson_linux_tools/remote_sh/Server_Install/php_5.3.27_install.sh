#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-04-07 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is php-5.3.27.tar.gz install
############## 记录日志用的变量
FaShongDuan_Host_IP=${2}
Local_Rsync_Password=$(eval echo "/ssh-x-server/remote_sh/Conf/rsync.password")
LocalHost_IP=`ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p'`
Time=$(date +%F\ %T)
mkdir -p /ssh-x-server/Log
php_install_dir_rpm_tar=/ssh-x-server/remote_sh/tools/php_install_rpm.tar
Log_name=$(basename `find ${php_install_dir_rpm_tar} -type f -name "php-5.3.27.tar.gz"`)
Path_Intall_log_ok=/ssh-x-server/Log/${Log_name}_Intall_ok.log
Path_Intall_log_false=/ssh-x-server/Log/${Log_name}_Intall_false.log
############## 记录日志用的变量

openssl_devel_dir_rpm=/ssh-x-server/remote_sh/tools/openssl-devel_rpm
mkdir -p /application/tar_xzf
# 本次要装14个依赖库

# 这是本地rpm包安装，共完成12个依赖库
rmp_sum=0
while (( ${rmp_sum} < 1 ))
do
    for n in $(ls ${openssl_devel_dir_rpm}/*.rpm)
    do
        rpm -i $n
    done
    rmp_sum=$(rpm -qa openssl-devel |wc -l)
    echo -e "Have lib_devel sum [ 1 ] now: 1 - ${rmp_sum} = $((1-${rmp_sum}))"
done
rmp_sum=1
while (( ${rmp_sum} < 11 ))
do
	for n in $(ls ${php_install_dir_rpm_tar}/php.rpm.devel/*.rpm)
 	do
 		rpm -iv $n &>/dev/null
 	done
	rmp_sum=$(rpm -qa zlib-devel libxml2-devel libjpeg-turbo-devel freetype-devel \
libpng-devel gd-devel libxslt-devel libmcrypt-devel mhash mhash-devel mcrypt |wc -l)
	echo -e "Have lib_devel sum [ 11 ] now: 11 - ${rmp_sum} = $((11-${rmp_sum}))"
done
# 第13个rpm包依赖库
yum -y install libcurl-devel &>/dev/null

# 显示本次装了13个rpm包依赖库
rpm -qa zlib-devel libxml2-devel libjpeg-turbo-devel freetype-devel libpng-devel gd-devel \
libxslt-devel libmcrypt-devel mhash mhash-devel mcrypt libcurl-devel openssl-devel 

# 源码安装第14个依赖库
tar zxf $(find ${php_install_dir_rpm_tar} -type f -name "libiconv*.tar.gz") -C /application/tar_xzf
cd /application/tar_xzf/libiconv-1.14
./configure --prefix=/usr/local/libiconv && make && make install

# 安装PHP主程序
tar zxf $(find ${php_install_dir_rpm_tar} -type f -name "php-5.3.27.tar.gz") -C /application/tar_xzf
cd /application/tar_xzf/php-5.3.27
./configure \
--prefix=/application/php-5.3.27 \
--with-mysql=/application/mysql \
--with-iconv-dir=/usr/local/libiconv \
--with-freetype-dir \
--with-jpeg-dir \
--with-png-dir \
--with-zlib \
--with-libxml-dir=/usr \
--enable-xml \
--disable-rpath \
--enable-safe-mode \
--enable-bcmath \
--enable-shmop \
--enable-sysvsem \
--enable-inline-optimization \
--with-curl \
--with-curlwrappers \
--enable-mbregex \
--enable-fpm \
--enable-mbstring \
--with-mcrypt \
--with-gd \
--enable-gd-native-ttf \
--with-openssl \
--with-mhash \
--enable-pcntl \
--enable-sockets \
--with-xmlrpc \
--enable-zip \
--enable-soap \
--enable-short-tags \
--enable-zend-multibyte \
--enable-static \
--with-xsl \
--with-fpm-user=nginx \
--with-fpm-group=nginx \
--enable-ftp

# 安装PHP主程序前要做的
[ -x /usr/lib64/lib/libmysqlclient.so.18 ] && rm -f /usr/lib64/lib/libmysqlclient.so.18
ln -s /application/mysql/lib/libmysqlclient.so.18  /usr/lib64/
touch ext/phar/phar.phar

make && make install
RETVAL=$?
[ -x /application/php ] && rm -fr /application/php
ln -s /application/php-5.3.27/ /application/php
# 生产环境用：
# cp -a php.ini-production /application/php/lib/php.ini
# 测试环境用：
/bin/cp -a php.ini-development /application/php/lib/php.ini
# 创建php-fpm.conf配置文件
cd /application/php/etc/ && /bin/cp -a php-fpm.conf.default php-fpm.conf
/application/php/sbin/php-fpm 
############# 记录安装日志，并发送到客户端
if [ $? -eq ${RETVAL} ];then
	echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ OK ] ${Time}">>${Path_Intall_log_ok}_${LocalHost_IP}
else
    echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ false ] ${Time}">>${Path_Intall_log_false}_${LocalHost_IP}
fi
rsync -az --password-file=${Local_Rsync_Password} \
$(eval echo "/ssh-x-server/Log") rsync_Log_Backup@${FaShongDuan_Host_IP}::Log_Backup
