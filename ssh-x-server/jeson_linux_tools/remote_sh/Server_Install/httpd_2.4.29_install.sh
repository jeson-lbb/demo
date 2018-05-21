#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-04-07 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is httpd-2.4.29.tar.gz install
############## 记录日志用的变量
FaShongDuan_Host_IP=${2}
Local_Rsync_Password=$(eval echo "/ssh-x-server/remote_sh/Conf/rsync.password")
LocalHost_IP=`ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p'`
Time=$(date +%F\ %T)
mkdir -p /ssh-x-server/Log
install_dir_rpm=/ssh-x-server/remote_sh/tools
Log_name=$(basename `find ${install_dir_rpm} -type f -name "httpd-2.4.29.tar.gz"`)
Path_Intall_log_ok=/ssh-x-server/Log/${Log_name}_Intall_ok.log
Path_Intall_log_false=/ssh-x-server/Log/${Log_name}_Intall_false.log
############## 记录日志用的变量

openssl_devel_dir_rpm=/ssh-x-server/remote_sh/tools/openssl-devel_rpm
install_rpm_sum=$(cat /ssh-x-server/remote_sh/tools/openssl-devel_rpm/install_rpm_sum.txt)
install_rpm_name_sum=$(cat /ssh-x-server/remote_sh/tools/openssl-devel_rpm/install_rpm_name_sum.txt)
mkdir -p /application/tar_xzf
# 本次要装15个依赖库

rmp_sum=0
while (( ${rmp_sum} < ${install_rpm_sum} ))
do
    for n in $(ls ${openssl_devel_dir_rpm}/*.rpm)
    do
        rpm -i $n 
    done
    rmp_sum=$(rpm -qa ${install_rpm_name_sum} |wc -l)
    echo -e "Have lib_devel sum [ ${install_rpm_sum} ] now: ${install_rpm_sum} - ${rmp_sum} = $((${install_rpm_sum}-${rmp_sum}))"
done

# 显示本次装了5个rpm包依赖库
rpm -qa ${install_rpm_name_sum}
# 这是本地rpm包安装，共完成12个依赖库
rmp_sum=1
while (( ${rmp_sum} < 11 ))
do
	for n in $(ls ${install_dir_rpm}/php_install_rpm.tar/php.rpm.devel/*.rpm)
 	do
 		rpm -iv $n &>/dev/null
 	done
	rmp_sum=$(rpm -qa zlib-devel libxml2-devel libjpeg-turbo-devel freetype-devel \
libpng-devel gd-devel libxslt-devel libmcrypt-devel mhash mhash-devel mcrypt |wc -l)
	echo -e "Have lib_devel sum [ 11 ] now: 11 - ${rmp_sum} = $((11-${rmp_sum}))"
done

# 显示本次装了14个rpm包依赖库
rpm -qa zlib-devel libxml2-devel libjpeg-turbo-devel freetype-devel libpng-devel gd-devel \
libxslt-devel libmcrypt-devel mhash mhash-devel mcrypt libcurl-devel openssl-devel bzip2-devel 
# 源码安装第15个依赖库
tar zxf $(find ${install_dir_rpm} -type f -name "apr-1.6.3.tar.gz") -C /application/tar_xzf
cd /application/tar_xzf/apr-1.6.3
./configure && make && make install
tar zxf $(find ${install_dir_rpm} -type f -name "apr-util-1.6.1.tar.gz") -C /application/tar_xzf
cd /application/tar_xzf/apr-util-1.6.1
./configure --prefix=/application/apr-util --with-apr=/usr/local/apr && make && make install
# 安装apache主程序
tar zxf $(find ${install_dir_rpm} -type f -name "httpd-2.4.29.tar.gz") -C /application/tar_xzf
cd /application/tar_xzf/httpd-2.4.29
./configure \
--prefix=/application/apache2.4.29.29 \
--enable-deflate \
--enable-expires \
--enable-headers \
--enable-modules=most \
--enable-so \
--enable-rewrite \
--with-mpm=worker \
--with-apr=/usr/local/apr \
--with-apr-util=/application/apr-util \
--enable-mods-shared=most

make && make install
RETVAL=$?
[ -x /application/apache ] && rm -fr /application/apache
ln -s /application/apache2.4.29.29/ /application/apache
# 启动apache
/application/apache/bin/apachectl -k restart
# 安装完成：下面是具体操作步骤与报错解决

# LAMP架构——Apache(httpd)-2.4.29.29源码安装
# 原创 2017年12月18日 00:23:52 标签：apache 642
# pache是一个基金会的名字，httpd才是我们要安装的软件包，早期它的名字就叫apache，Apache官网www.apache.org
# 由于httpd2.2和httpd2.4.29所所使用的Apr库不同，而且centos7系统自带的Apr与之不匹配，所以需要使用yum安装Apr库文件。
# 
# [root@dl-001 src]#  wget http://mirrors.cnnic.cn/apache/httpd/httpd-2.4.29.29.tar.gz   //2.4.29源码包
# 
# [root@dl-001 src]#  wget  http://mirrors.cnnic.cn/apache/apr/apr-1.6.3.tar.gz       //apr-1.6.3r包
# 
# [root@dl-001 src]#  wget  http://mirrors.cnnic.cn/apache/apr/apr-util-1.6.1.tar.gz  //apr-util-1.6.1包
# 说明:下载并解压，以下操作需要进入。
# 
# 1,安装apr包
# 
# [root@dl-001 src]# cd apr-1.6.3
# 配置：
# [root@dl-001 apr-1.6.3]# ./configure
# 
# 报错：
# configure: error: in `/application/src/apr-1.6.3':
# configure: error: no acceptable C compiler found in $PATH
# See `config.log' for more details
# //说明：缺少C语言相关的编译器。  
# 
# 解决办法：
# [root@dl-001 apr-1.6.3]# yum install -y gcc*    //安装gcc编译器。  
# 
# [root@dl-001 apr-1.6.3]# ./configure
# // 配置成功！
# 
# 编译和安装：
# [root@dl-001 apr-1.6.3]# make 
# 
# 报错：  
# xml/apr_xml.c:35:19: 致命错误：expat.h：没有那个文件或目录
#  #include <expat.h>
#                    ^
# 编译中断。
# make[1]: *** [xml/apr_xml.lo] 错误 1
# make[1]: 离开目录“/application/src/apr-util-1.6.0”
# make: *** [all-recursive] 错误 1
# 
# 解决办法：
# [root@dl-001 apr-1.6.3]# yum -y install expat-devel
# 
# [root@dl-001 apr-1.6.3]# make && make install
# [root@dl-001 apr-1.6.3]# echo $?
# 0
# 注意： APR 1.6.2版本有变更，进行了加密设置，进行编译时需要使用如下命令(否则在安装Apache是无法调用该库文件)：
# 
# [root@dl-001 httpd-2.4.29.29]# CC="gcc -m64" ./configure
# 2,安装Apr-util包
# 
# [root@dl-001 src]# cd apr-util-1.6.1
# [root@dl-001 apr-util-1.6.1]# ./configure --prefix=/application/apr-util --with-apr=/usr/local/apr
# [root@dl-001 apr-util-1.6.1]# echo $?
# 0
# 
# 编译和安装：
# [root@dl-001 apr-util-1.6.1]# make && make install
# 3,安装httpd
# 
# [root@dl-001 src]# cd httpd-2.4.29.29 
# [root@dl-001 httpd-2.4.29.29]# ./configure \
# --prefix=/application/apache2.4.29.29 \
# --enable-deflate \
# --enable-expires \
# --enable-headers \
# --enable-modules=most \
# --enable-so \
# --enable-rewrite \
# --with-mpm=worker \
# --with-apr=/usr/local/apr \
# --with-apr-util=/application/apr-util \
# --enable-mods-shared=most
# 
# 报错：
# configure: error: pcre-config for libpcre not found. PCRE is required and available from http://pcre.org/  
# 说明：需要安装库文件pcre
# 
# 解决办法：
# 
# [root@dl-001 httpd-2.4.29.29]# yum list |grep pcre     //查看相关的包
# 
# 请根据搜索的结果安装下面的包：
# [root@dl-001 httpd-2.4.29.29]# yum install -y pcre-devel
# 
# [root@dl-001 httpd--2.4.29.29]# ./configure --prefix=/application/apache2.4.29 --with-apr=/usr/local/apr --with-apr-util=/application/apr-util --enable-so --enable-mods-shared=most
# [root@dl-001 httpd-2.4.29.29]# echo $?
# 0
# 
# //编译和安装
# 
# [root@dl-001 httpd-2.4.29.29]# make
# 
# 
# [root@dl-001 httpd-2.4.29.29]# make install
# [root@dl-001 httpd-2.4.29.29]# echo $?
# 0
# 排查错误
# 
# 在源码编译安装httpd时，./configure执行无错误，到make时就报错
# 
# 错误如下:
# 
# ...
# /application/apr-util/lib/libaprutil-1.so: undefined reference to `XML_StopParser'
# /application/apr-util/lib/libaprutil-1.so: undefined reference to `XML_Parse'
# /application/apr-util/lib/libaprutil-1.so: undefined reference to `XML_ErrorString'
# /application/apr-util/lib/libaprutil-1.so: undefined reference to `XML_SetElementHandler'
# collect2: error: ld returned 1 exit status
# make[2]: *** [htpasswd] 错误 1
# make[2]: 离开目录“/application/src/httpd-2.4.29.28/support”
# make[1]: *** [all-recursive] 错误 1
# make[1]: 离开目录“/application/src/httpd-2.4.29.28/support”
# make: *** [all-recursive] 错误 1
# 说明：缺少了xml相关的库，需要安装libxml2-devel包。直接安装并不能解决问题，因为httpd调用的apr-util已经安装好了，但是apr-util并没有libxml2-devel包支持
# 1.安装libxml2-devel包 
# [root@dl-001 ~]# yum install -y libxml2-devel
# 
# 2.删除apr-util安装目录，并重新编译安装
# 
# [root@dl-001 ~]# rm -rf /application/apr-util
# [root@dl-001 ~]# cd /application/src/apr-util-1.6.1
# 
# # 这一步很重要，必须清除之前配置时的缓存
# [root@dl-001 apr-util-1.6.1]# make clean
# 
# # 源码安装三步走
# [root@dl-001 apr-util-1.6.1]# ./configure --prefix=/application/apr-util --with-apr=/usr/local/apr
# [root@dl-001 apr-util-1.6.1]# make
# [root@dl-001 apr-util-1.6.1]# make install
# 3.重新编译安装httpd
# 
# # 同样要清理之前的缓存十分重要
# [root@dl-001 src]# cd /application/src/httpd-2.4.29.28
# [root@dl-001 httpd-2.4.29.29]# make clean
# [root@dl-001 httpd-2.4.29.29]# ./configure --prefix=/application/apache2.4.29  --with-apr=/usr/local/apr --with-apr-util=/application/apr-util --enable-so --enable-mods-shared=most
# [root@dl-001 httpd-2.4.29.29]# make
# # 这时make没报错了
# 
# [root@dl-001 httpd-2.4.29.29]# make install
# 4.启动服务
# 
# [root@dl-001 httpd-2.4.29.29]# cd /application/apache2.4.29     //切换至Apache2.4.29目录
# [root@dl-001 apache2.4.29]# ls
# bin  build  cgi-bin  conf  error  htdocs  icons  include  logs  man  manual  modules
# 注：较常用目录bin（可执行文件存放目录）、conf（配置文件所在目录）、htdocs（存放一个访问页）、logs（日志文件存放目录）、modules（存放扩展模块）。 
# 
# 查看Apache所加载的模块：
# [root@dl-001 apache2.4.29]# /application/apache2.4.29/bin/httpd -M 
# 或者
# [root@dl-001 apache2.4.29]# /application/apache2.4.29/bin/apachectl -M 
# 
# 启动：
# 
# [root@dl-001 apache2.4.29]# /application/apache2.4.29/bin/apachectl start
# AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using fe80::65d2:adc:20d3:8c74. Set the 'ServerName' directive globally to suppress this message
# #此处错误提示没影响。
# 
# 检测状态：
# [root@dl-001 apache2.4.29]# ps aux |grep httpd
# root      8090  0.0  0.2 144572  2720 ?        Ss   23:36   0:00 /application/apache2.4.29/bin/httpd -k start
# daemon    8091  0.0  0.1 144572  1996 ?        S    23:36   0:00 /application/apache2.4.29/bin/httpd -k start
# daemon    8092  0.0  0.1 144572  1996 ?        S    23:36   0:00 /application/apache2.4.29/bin/httpd -k start
# daemon    8093  0.0  0.1 144572  1996 ?        S    23:36   0:00 /application/apache2.4.29/bin/httpd -k start
# daemon    8094  0.0  0.1 144572  1996 ?        S    23:36   0:00 /application/apache2.4.29/bin/httpd -k start
# daemon    8095  0.0  0.1 144572  1996 ?        S    23:36   0:00 /application/apache2.4.29/bin/httpd -k start
# root      8116  0.0  0.0 112680   972 pts/4    S+   23:38   0:00 grep --color=auto httpd
# [root@dl-001 apache2.4.29]# netstat -lntp
# Active Internet connections (only servers)
# Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
# tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      1181/sshd           
# tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      1790/master         
# tcp6       0      0 :::80                   :::*                    LISTEN      8090/httpd          
# tcp6       0      0 :::22                   :::*                    LISTEN      1181/sshd           
# tcp6       0      0 ::1:25                  :::*                    LISTEN      1790/master 

############# 记录安装日志，并发送到客户端
if [ $? -eq ${RETVAL} ];then
	echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ OK ] ${Time}">>${Path_Intall_log_ok}_${LocalHost_IP}
else
    echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ false ] ${Time}">>${Path_Intall_log_false}_${LocalHost_IP}
fi
rsync -az --password-file=${Local_Rsync_Password} \
$(eval echo "/ssh-x-server/Log") rsync_Log_Backup@${FaShongDuan_Host_IP}::Log_Backup
