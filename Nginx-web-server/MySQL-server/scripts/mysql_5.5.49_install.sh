#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-04-07 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is mysql install
############## 记录日志用的变量
FaShongDuan_Host_IP=${2}
Local_Rsync_Password=$(eval echo "/etc/rsync.password")
LocalHost_IP=`ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p'`
Time=$(date +%F\ %T)
Log_name=mysql-5.5.49-linux2.6-x86_64.tar.gz
Path_Intall_log_ok=~/Log/${Log_name}_Intall_ok.log
Path_Intall_log_false=~/Log/${Log_name}_Intall_false.log
############## 记录日志用的变量

id mysql &>/dev/null || useradd -s /sbin/nologin -M mysql
mkdir -p /application/tar_xzf ~/Log /backup /server/{scripts,tools} /etc/yum.repos.d/repos.bak
cd /MySQL-server/conf/ && /bin/cp -ab hosts mail.rc rsync.password sudoers /etc/
/bin/cp -ab rc.local /etc/rc.d
/bin/cp -ab root /var/spool/cron/
/bin/mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/repos.bak
/bin/cp -ab etiantian.repo /etc/yum.repos.d/
/bin/cp -ab /MySQL-server/scripts/cli_rsync_bak.sh /server/scripts/

cd /server/tools
wget http://yum.etiantian.org/tar.gzs/bak_wordpress_bbs_www_phpMyAdmin_2018-04-19.sql.gz
wget http://yum.etiantian.org/tar.gzs/mysql-5.5.49-linux2.6-x86_64.tar.gz

# 定义MySQL默认的安装目录为/application/ == /application
tar xzf /server/tools/mysql-5.5.49-linux2.6-x86_64.tar.gz -C /application

# 创建MySQL安装目录的链接目录为/mysql
	cd /application 
 	rm -fr mysql 
	ln -s mysql-5.5.49-linux2.6-x86_64/ mysql
# 安装MySQL完成。下面是始化MySQL数据库
# 初始化MySQL数据库，主要是生成/application/mysql/data/ 下/application/mysql/support-files/的库文件
	/application/mysql/scripts/mysql_install_db --basedir=/application/mysql/ --datadir=/application/mysql/data/ --user=mysql

# 创建MySQL默认的读取的配置文件：/etc/my.cnf 
#	sed -nr '/^#/!p' /application/mysql/support-files/my-small.cnf |uniq>/etc/my.cnf
	cd /MySQL-server/conf/ && /bin/cp -ab my.cnf /etc/ 
#修改启动脚本里的路径
	sed -i "s#/usr/local/mysql#/application/mysql#g" /application/mysql/support-files/mysql.server
	sed -i "s#/usr/local/mysql#/application/mysql#g" /application/mysql/bin/mysqld_safe

# 配置MySQL在chkconfig开机启动
	/bin/cp -ab /application/mysql/support-files/mysql.server /etc/init.d/mysqld
	/sbin/chkconfig mysqld on
# 可以用 echo "export PATH=/application/mysql/bin:$PATH">>suorce /etc/profile
# suorce /etc/profile
	cp -ab /application/mysql/bin/* /usr/local/bin/
# 启动MySQL
	#要启动数据库以后才能修改密码和恢复数据		注意
	/etc/init.d/mysqld start
	RETVAL=$?
# 为MySQL设置密码为123456
	mysqladmin -u root password 123456
# MySQL库恢复
	cd /server/tools
	gzip -d /server/tools/bak_wordpress_bbs_www_phpMyAdmin_2018-04-19.sql.gz
	mysql -uroot -p123456 < bak_wordpress_bbs_www_phpMyAdmin_2018-04-19.sql



# mysqladmin shutdown 只带的优雅停止
# mysqladmin -u root -p123456 password 234567 # 修改MySQL用户密码
# mysql -u root -p 		# 登录MySQL
# 免密码登录
# /application/mysql/bin/mysqld_safe --skip-grant-table &  ;mysql
# 然后命令行修改密码：update mysql.user set password=PASSWORD("234567") where host='localhost' and user='test';
# MySQL内部命令：
# show show version();			 查看版本
# show databases;				（显示库）====>ls
# drop database test;			（删库）
# create database wordpress; 	（创建库）
# show tables;					（显示表）
# use mysql;					（切换库）====>cd
# select * from old_posts\G;	（查看rewriteURL连接ID伪静态）
# select database();			（显示当前所在的库）===>pwd
# select user,host from mysql.user;【选择用户（用户是有用户名和主机确定的）】
# select user();				（查当前用户）===>whoami
# system whoami ====>Linux 下的whoami
# drop user 'root'@'web\_lnmp02';（删普通用户）
# delete from mysql.user where user="root" and host="A";（删特殊字符主机）
# grant all on *.* to jeson@localhost identified by '123456' with grant option;flush privileges;（创建用户;并授权成管理员）
# update mysql.user set host='10.0.0.%' where host='localhost' and user='root';(root@localhost改root@10.0.0.%)
# grant create,insert,delete,update,select on bbs.* to bbs@'10.0.0.%' identified by '123456';(创建用户,指定权限）
# show grants for wordpress@'localhost';（查看用户授权）
# select * from mysql.user;		（查看用户的密码）
# flush privileges;				（刷新，使其生效）
# mysql -ubbs -p123456 -h 10.0.0.30 (远程连接要连接的IP)
######################
# MySQL库的迁移：
	# 备份库
	# (1) 单库备份：mysqldump -u wordpress -p123456 -B    -x wordpress|gzip>bak_wordpress_$(date +%F).sql.gz
	# (2) 多库备份：mysqldump -u wordpress -p123456 -B    -x a b c d|gzip>bak_备份所有库_$(date +%F).sql.gz    
	# (3) 全库备份：mysqldump -u wordpress -p123456 -B -A -x|gzip>bak_多个库同时备份_$(date +%F).sql.gz 
# MySQL库恢复：
	# （1）解压，会删除源文件：gzip -d bak_wordpress_2018-04-11.sql.gz 
	# （2）远端数据库创建WordPress库的管理用户
	# 	   grant create,insert,delete,update,select on wordpress.* to wordpress@'10.0.0.%' identified by '123456';
	# （3）恢复远端数据库：mysql -uroot -p123456 wordpress < bak_2018-04-11.wordpress.sql 
	# （4）WordPress配置做域名连接远端数据库IP
	#      /application/nginx/html/blog/wp-config.php ====> /** MySQL主机 */===> define('DB_HOST', 'db.etiantian.org');
	# （5）本地做远端数据库IP域名hosts解析：/etc/hosts ===> 10.0.0.30   db.etiantian.org
############# 记录安装日志，并发送到客户端
if [ 0 -eq ${RETVAL} ];then
    echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ OK ] ${Time}">>${Path_Intall_log_ok}_${LocalHost_IP}
else
    echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ false ] ${Time}">>${Path_Intall_log_false}_${LocalHost_IP}
fi
rsync -az --password-file=${Local_Rsync_Password} $(eval echo "~/Log") rsync_backup@${FaShongDuan_Host_IP}::Log_Backup
