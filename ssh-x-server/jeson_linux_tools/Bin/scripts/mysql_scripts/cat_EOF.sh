#!/bin/bash
cat<<-EOF
# 为MySQL设置密码为123456
        mysqladmin -u root password 123456

# mysqladmin shutdown 只带的优雅停止
# mysqladmin -u root -p123456 password 234567 # 修改MySQL用户密码
# mysql -u root -p              # 登录MySQL
# 免密码登录
# /application/mysql/bin/mysqld_safe --skip-grant-table &  ;mysql
# 然后命令行修改密码：update mysql.user set password=PASSWORD("234567") where host='localhost' and user='test';
# MySQL内部命令：
# show show version();                   查看版本
# show databases;                               （显示库）====>ls
# drop database test;                   （删库）
# create database wordpress;    （创建库）
# show tables;                                  （显示表）
# use mysql;                                    （切换库）====>cd
# select * from old_posts\G;    （查看rewriteURL连接ID伪静态）
# select database();                    （显示当前所在的库）===>pwd
# select user,host from mysql.user;【选择用户（用户是有用户名和主机确定的）】
# select user();                                （查当前用户）===>whoami
# system whoami ====>Linux 下的whoami
# drop user 'root'@'web\_lnmp02';（删普通用户）
# delete from mysql.user where user="root" and host="A";（删特殊字符主机）
# grant all on *.* to jeson@localhost identified by '123456' with grant option;flush privileges;（创建用户）
# update mysql.user set host='10.0.0.%' where host='localhost' and user='root';(root@localhost改root@10.0.0.%)
# grant create,insert,delete,update,select on bbs.* to bbs@'10.0.0.%' identified by '123456';(创建用户,指定权限）
# show grants for wordpress@'localhost';（查看用户授权）
# select * from mysql.user;             （查看用户的密码）
# flush privileges;                             （刷新，使其生效）
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
        #          grant create,insert,delete,update,select on wordpress.* to wordpress@'10.0.0.%' identified by '123456';
        # （3）恢复远端数据库：mysql -uroot -p123456 wordpress < bak_2018-04-11.wordpress.sql 
        # （4）WordPress配置做域名连接远端数据库IP
        #      /application/nginx/html/blog/wp-config.php ====> /** MySQL主机 */===> define('DB_HOST', 'db.etiantian.org');
        # （5）本地做远端数据库IP域名hosts解析：/etc/hosts ===> 10.0.0.30   db.etiantian.org
	EOF
