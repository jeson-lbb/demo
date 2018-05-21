#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
# Date:   01:17 2018-04-07 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is { 1 create eth0 and eth1 2 chkconfig 3 sshd_config 4 sysctl.conf }

ROUTE=$(route -n|grep "^0.0.0.0"|awk '{print $2}')
BROADCAST=$(/sbin/ifconfig eth0|grep -i bcast|awk '{print $3}'|awk -F":" '{print $2}')
HWADDR=$(/sbin/ifconfig eth0|grep -i HWaddr|awk '{print $5}')
IPADDR=$(/sbin/ifconfig eth0|grep "inet addr"|awk '{print $2}'|awk -F":" '{print $2}')
NETMASK=$(/sbin/ifconfig eth0|grep "inet addr"|awk '{print $4}'|awk -F":" '{print $2}')
cat >/etc/sysconfig/network-scripts/ifcfg-eth0<<-EOF
DEVICE=eth0
BOOTPROTO=static
BROADCAST=$BROADCAST
HWADDR=$HWADDR
IPADDR=$IPADDR
NETMASK=$NETMASK
GATEWAY=$ROUTE
ONBOOT=yes
EOF
IPADDR1=$(echo $IPADDR|awk -F"." '{print $4}')
cat >/etc/sysconfig/network-scripts/ifcfg-eth1<<-EOF
DEVICE=eth1
BOOTPROTO=static
BROADCAST=10.0.0.255
IPADDR=10.0.0.$IPADDR1
NETMASK=255.255.255.0
ONBOOT=yes
EOF
Rurrency_Chkconfig_Set(){
    for Chk_off_Name in `chkconfig --list|grep "3:on"|awk '{print $1}'`
    do
         chkconfig  "$Chk_off_Name" off
    done
    for Chk_on_Name in crond network rsyslog sshd sysstat
    do
         chkconfig  "$Chk_on_Name" on
    done
}
cd /tmp/Kickstart/conf/ && /bin/cp -ab sshd_config /etc/ssh/ && /bin/cp -ab sysctl.conf /etc/
Rurrency_Chkconfig_Set
