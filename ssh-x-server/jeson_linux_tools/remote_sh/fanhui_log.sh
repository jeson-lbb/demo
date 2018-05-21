############## 记录日志用的变量
FaShongDuan_Host_IP=${2}
Local_Rsync_Password=$(eval echo "/ssh-x-server/remote_sh/Conf/rsync.password")
LocalHost_IP=`ifconfig eth0|sed -rn '2s/^.*ddr:(.*)  B.*$/\1/p'`
Time=$(date +%F\ %T)
mkdir -p /ssh-x-server/Log

Log_name===========================$(basename /ssh-x-server/remote_sh/tools/packages/mysql-5.5.49-linux2.6-x86_64.tar.gz)=============

Path_Intall_log_ok=/ssh-x-server/Log/${Log_name}_Intall_ok.log
Path_Intall_log_false=/ssh-x-server/Log/${Log_name}_Intall_false.log
############## 记录日志用的变量

   ==================== /etc/init.d/mysqld start ==================
RETVAL=$?


############# 记录安装日志，并发送到客户端
if [ $? -eq ${RETVAL} ];then
    echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ OK ] ${Time}">>${Path_Intall_log_ok}_${LocalHost_IP}
else
    echo "Remote Intall [ ${Log_name} ] to $USER@$LocalHost_IP  --- [ false ] ${Time}">>${Path_Intall_log_false}_${LocalHost_IP}
fi
rsync -az --password-file=${Local_Rsync_Password} $(eval echo "/ssh-x-server/Log") rsync_Log_Backup@${FaShongDuan_Host_IP}::Log_Backup
