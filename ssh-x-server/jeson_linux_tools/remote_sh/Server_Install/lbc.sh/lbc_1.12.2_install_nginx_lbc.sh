#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
#--with-mail --with-mail_ssl_module
path=$1
id nginx &>/dev/null
if [ $? -eq 1 ] ;then
   useradd -M -s /sbin/nologin nginx
fi
cd $1 && \
./configure \
--user=nginx \
--group=nginx \
--prefix=/Applications/nginx-1.12.2/ \
--with-http_stub_status_module \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-pcre \
--with-http_addition_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_auth_request_module \
--with-threads \
--with-stream \
--with-stream_ssl_module \
--with-file-aio 
