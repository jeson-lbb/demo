#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-04-07 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is kickstart install
yum -y install dhcp
lan_IP=$(/sbin/ifconfig eth1|awk -F "[ :]+" '/inet addr/{print $4}'|sed -rn 's/(.*\.)[0-9]+/\1/p')
yum_IP=$(/sbin/ifconfig eth0|awk -F "[ :]+" '/inet addr/{print $4}')
tftp_http_IP=$(/sbin/ifconfig eth1|awk -F "[ :]+" '/inet addr/{print $4}')
cat >/etc/dhcp/dhcpd.conf<<-EOF
ddns-update-style none;
ignore client-updates;
subnet ${lan_IP}0 netmask 255.255.255.0{
    range ${lan_IP}100 ${lan_IP}200;
    option subnet-mask 255.255.255.0;
    default-lease-time 21600;
    max-lease-time 43200;
    next-server ${tftp_http_IP};
    filename "/pxelinux.0";
}
EOF
cat >/etc/sysconfig/dhcpd<<-EOF
# Command line options here
DHCPDARGS=eth1
EOF
/etc/init.d/dhcpd restart
# 安装简单文件传输协议
yum -y install tftp-server
cat >/etc/xinetd.d/tftp<<-EOF
# default: off
# description: The tftp server serves files using the trivial file transfer \
#   protocol.  The tftp protocol is often used to boot diskless \
#   workstations, download configuration files to network-aware printers, \
#   and to start the installation process for some operating systems.
service tftp
{
    socket_type     = dgram
    protocol        = udp
    wait            = yes
    user            = root
    server          = /usr/sbin/in.tftpd
    server_args     = -s /var/lib/tftpboot
    disable         = no
    per_source      = 11
    cps         = 100 2
    flags           = IPv4
}
EOF
/etc/init.d/xinetd restart

# 安装web服务
yum -y install httpd
/bin/cp -ab /ssh-x-server/Kickstart/conf/httpd.conf /etc/httpd/conf/
sed -ri "s#ServerAlias yum.etiantian.org#ServerAlias ${yum_IP}#g" /etc/httpd/conf/httpd.conf
sed -ri "s#ServerAlias centos.etiantian.org#ServerAlias ${tftp_http_IP}#g" /etc/httpd/conf/httpd.conf
/etc/init.d/httpd restart
mkdir -p /var/www/html/centos6.9 /var/lib/tftpboot/pxelinux.cfg

# 挂载Linux安装镜像文件
mount /dev/cdrom /var/www/html/centos6.9/
[ $? -ne 0 ] && { echo /dev/cdrom are have not iso file ;exit 30 ; }
echo "/bin/mount /dev/cdrom /var/www/html/centos6.9/" >>/etc/rc.local
# 拷贝安装过程中的自动填写文件。ks.cfg
/bin/cp -a /ssh-x-server/Kickstart/conf/ks.cfg /var/www/html
sed -ri "s#centos.etiantian.org#${tftp_http_IP}#g" /var/www/html/ks.cfg

# tftpboot 拷贝Linux安装引导加载程序
/bin/cp -a /ssh-x-server/Kickstart/conf/pxelinux.0 /var/lib/tftpboot
# tftpboot 拷贝Linux安装启动菜单程序文件
/bin/cp -a /var/www/html/centos6.9/isolinux/* /var/lib/tftpboot
# tftpboot 客户端的配置文件
cat >/var/lib/tftpboot/pxelinux.cfg/default<<-EOF
default ks
prompt 0
label ks
    kernel vmlinuz
    append initrd=initrd.img ks=http://${tftp_http_IP}/ks.cfg ksdevice=eth1
EOF
# 优化文件描述符
echo '*               -       nofile          65535 ' >>/etc/security/limits.conf
