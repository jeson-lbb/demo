#!/bin/bash
# Date:   01:17 2018-04-05 
# Author: Created by Jeson
# Mail:   309769163@qq.com
# Funcsion:This scripts funcsion is Nginx log lun xun
DateFormat=$(date +%F -d -1day)
BaseDir=/application/nginx/
NginxLogDir=${BaseDir}logs
LogName='access_*.log'
SedLogName='^access_.+\.log'
[ -d ${NginxLogDir} ] && cd ${NginxLogDir} || exit 10
[ ! -f $(/bin/ls -t1 ${LogName}|head -n 1) ] && exit 11
/bin/ls|/bin/sed -r "s#${SedLogName}#/bin/mv & ${DateFormat}_&#eg"
${BaseDir}/sbin/nginx -s reload
