#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-04-07 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is php-5.6.35.tar.gz install
############## 记录日志用的变量
FaShongDuan_Host_IP=${2}
Local_Rsync_Password=$(eval echo "/etc/rsync.password")
LocalHost_IP=`ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p'`
Time=$(date +%F\ %T)
Log_name=php-5.6.35.tar.gz
Path_Intall_log_ok=~/Log/${Log_name}_Intall_ok.log
Path_Intall_log_false=~/Log/${Log_name}_Intall_false.log
############## 记录日志用的变量

mkdir -p /application/tar_xzf ~/Log /backup  /server/{scripts,tools}
yum -y install libcurl-devel zlib-devel libxml2-devel libjpeg-turbo-devel freetype-devel libpng-devel \
gd-devel libxslt-devel libmcrypt-devel mhash mhash-devel mcrypt libcurl-devel openssl-devel bzip2-devel 

cd /server/scripts &&
wget http://yum.etiantian.org/tar.gzs/libiconv-1.14.tar.gz
wget http://yum.etiantian.org/tar.gzs/php-5.6.35.tar.gz 

tar zxf /server/scripts/libiconv-1.14.tar.gz -C /application/tar_xzf
cd /application/tar_xzf/libiconv-1.14
./configure --prefix=/usr/local/libiconv && make -j 4 && make install

# 安装PHP主程序
tar zxf /server/scripts/php-5.6.35.tar.gz -C /application/tar_xzf
cd /application/tar_xzf/php-5.6.35
./configure \
--prefix=/application/php-5.6.35 \
--with-mysql=mysqlnd \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-iconv-dir=/usr/local/libiconv \
--with-freetype-dir \
--with-jpeg-dir \
--with-png-dir \
--with-zlib \
--with-libxml-dir=/usr \
--enable-xml \
--disable-rpath \
--enable-bcmath \
--enable-shmop \
--enable-sysvsem \
--enable-inline-optimization \
--with-curl \
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
--enable-soap \
--enable-short-tags \
--enable-static \
--with-xsl \
--with-fpm-user=nginx \
--with-fpm-group=nginx \
--enable-zip \
--with-bz2 \
--enable-ftp \
--with-apxs2=/application/apache/bin/apxs \
#--enable-opcache #操作码缓存

# 安装PHP主程序前要做的
rm -f /usr/lib64/libmysqlclient.so.18
ln -s /application/mysql/lib/libmysqlclient.so.18  /usr/lib64/
touch ext/phar/phar.phar
make -j 4 && make install
RETVAL=$?
[ -x /application/php ] && rm -fr /application/php
ln -s /application/php-5.6.35/ /application/php
# 生产环境用：
# cp -ab php.ini-production /application/php/lib/php.ini
# 测试环境用：
/bin/cp -ab /Apache-web-server/conf/php.ini /application/php/lib/php.ini
# 创建php-fpm.conf配置文件
/bin/cp -ab /Apache-web-server/conf/php-fpm.conf /application/php/etc/php-fpm.conf
mkdir -p /application/php-5.6.35/log
touch /application/php-5.6.35/log/www.log.slow

# 装完 PHP主程序 以后加上这句，装”touch ext/phar/phar.phar”的真实文件
# /application/php/bin/php /server/tools/go-pear.phar
yum -y install expect
cd /server/scripts &&
wget http://yum.etiantian.org/tar.gzs/go-pear.phar
/bin/cp -ab /Apache-web-server/scripts/phar_install.exp  /server/scripts
expect  /server/scripts/phar_install.exp


############# 记录安装日志，并发送到客户端
if [ 0 -eq ${RETVAL} ];then
	echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ OK ] ${Time}">>${Path_Intall_log_ok}_${LocalHost_IP}
else
    echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ false ] ${Time}">>${Path_Intall_log_false}_${LocalHost_IP}
fi
rsync -az --password-file=${Local_Rsync_Password} \
$(eval echo "~/Log") rsync_backup@${FaShongDuan_Host_IP}::Log_Backup
