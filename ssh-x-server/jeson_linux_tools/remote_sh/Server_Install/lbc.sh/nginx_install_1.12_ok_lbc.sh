#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
#安装nginx的依赖包
yum install gcc-c++ -y && \
yum install pcre pcre-devel -y && \
yum install openssl openssl-devel -y && \
yum install zlib-devel -y && \

id nginx &>/dev/null
if [ $? -eq 1 ] ;then
   useradd -M -s /sbin/nologin nginx
fi
cd $1 && \
./configure --user=nginx --group=nginx --prefix=$2 \
--with-http_stub_status_module \
--with-http_ssl_module \
--with-http_v2_module 


#注解 nginx 编译参数功能,大约分四类：
# 1 类基本的配置（路径等）
# 2 类默认开启功能，
# 3 类是默认关闭功能
# 4 编译相关

#--prefix=PATH 
#set installation prefix #Nginx安装的根路径,默认为 /usr/local/nginx。 

#--sbin-path=PATH 
#set nginx binary pathname #指定nginx二进制文件的路径,默认为PATH/sbin/nginx。 

#--modules-path=PATH 
#set modules path #Perl模块位置 

#--conf-path=PATH 
#set nginx.conf pathname #设定nginx配置文件地址，默认为PATH/conf/nginx.conf。 

#--error-log-path=PATH 
#set error log pathname #错误文件路径，默认为 PATH/logs/error.log。 

#--pid-path=PATH
#set nginx.pid pathname # master进程pid写入的文件位置,通常在var/run下，默认为 PATH/logs/nginx.pid。 

#--lock-path=PATH
#set nginx.lock pathname #共享存储器互斥锁文件路径 

#--user=USER
#set non-privileged user for worker processes #指定程序运行时的非特权用户 

#--group=GROUP
#set non-privileged group for worker processes #指定程序运行时的非特权用户组 

#--build=NAME
#set build name #编译名称 

#--builddir=DIR
# set build directory #指向编译目录 

#--with-select_module
# enable select module 允许或不允许开启SELECT模式，如果configure没有找到合适的模式，比如，kqueue(sun os)、epoll(linux kenel 2.6+)、rtsig(实时信号) 

#--without-select_module
# disable select module 禁用select模块支持 

#--with-poll_module
# enable poll module 启用poll模块支持（功能与select相同，与select特性相同，为一种轮询模式,不推荐在高载环境下使用） 

#--without-poll_module
# disable poll module 禁用poll模块支持 
  
#--with-threads
# enable thread pool support 
  
#--with-file-aio
# enable file AIO support #为freeBSD4.3+和linux2.6.22+系统启用异步io 
  
#--with-ipv6
# enable IPv6 support #启用ipv6支持 
    
#---------默认禁用的模块---------default off 

#--with-http_ssl_module
# enable ngx_http_ssl_module #使支持https请求，需已安装openssl 

#--with-http_v2_module
# enable ngx_http_v2_module #启用HTTP V2 

#--with-http_realip_module
# enable ngx_http_realip_module #此模块支持显示真实来源IP地址，主要用于NGINX做前端负载均衡服务器使用 

#--with-http_addition_module
# enable ngx_http_addition_module #输出过滤器,使你能够在请求经过一个location前或后时在该location本身添加内容

#--with-http_xslt_module
# enable ngx_http_xslt_module #这个模块是一个过滤器，它可以通过XSLT模板转换XML应答 

#--with-http_xslt_module=dynamic
# enable dynamic ngx_http_xslt_module  

#--with-http_image_filter_module
# enable ngx_http_image_filter_module #图像过滤器,在将图像投递到客户之前进行处理(需要libgd库) 

#--with-http_image_filter_module=dynamic 
# enable dynamic ngx_http_image_filter_module  

#--with-http_geoip_module
# enable ngx_http_geoip_module #创建基于与MaxMind GeoIP相配的客户端地址 

#--with-http_geoip_module=dynamic
# enable dynamic ngx_http_geoip_module 

#--with-http_sub_module
# enable ngx_http_sub_module #这个模块可以能够在nginx的应答中搜索并替换文本 

#--with-http_dav_module
# enable ngx_http_dav_module #为文件和目录指定权限，限制不同类型的用户对于页面有不同的操作权限 

#--with-http_flv_module 
# enable ngx_http_flv_module #这个模块支持对FLV（flash）文件的拖动播放 

#--with-http_mp4_module 
# enable ngx_http_mp4_module #支持H.264/AAC文件为伪流媒体 

#--with-http_gunzip_module
# enable ngx_http_gunzip_module #对于不支持gzip编码的客户,该模块用于为客户解压缩预压缩内容 

#--with-http_gzip_static_module
# enable ngx_http_gzip_static_module #这个模块在一个预压缩文件传送到开启Gzip压缩的客户端之前检查是否已经存在以“.gz”结尾的压缩文件，这样可以防止文件被重复压缩 

#--with-http_auth_request_module 
# enable ngx_http_auth_request_module  

#--with-http_random_index_module
# enable ngx_http_random_index_module #从目录中选择一个随机主页 

#--with-http_secure_link_module
# enable ngx_http_secure_link_module #该模块提供一种机制,它会将一个哈希值链接到一个url中,因此,只有那些使用正确的密码能够计算链接 

#--with-http_degradation_module
# enable ngx_http_degradation_module #允许在内存不足的情况下返回204或444码 

#--with-http_slice_module 
# enable ngx_http_slice_module  

#--with-http_stub_status_module
# enable ngx_http_stub_status_module #取得一些nginx的运行状态，输出的状态信息可使用RRDtool或类似的工具绘制成图 

#---------默认启用的模块---------default on

#--without-http_charset_module
# disable ngx_http_charset_module #重新编码web页面 

#--without-http_gzip_module
# disable ngx_http_gzip_module #同-with-http_gzip_static_module功能一样 

#--without-http_ssi_module
# disable ngx_http_ssi_module #提供在输入端处理处理服务器包含文件（SSI）的过滤器，目前支持SSI命令的列表是不完整的 

#--without-http_userid_module
# disable ngx_http_userid_module #用来处理用来确定客户端后续请求的cookies 

#--without-http_access_module
# disable ngx_http_access_module #供了一个简单的基于主机的访问控制。允许/拒绝基于ip地址 

#--without-http_auth_basic_module 
# disable ngx_http_auth_basic_module #可以使用用户名和密码基于http基本认证方法来保护你的站点或其部分内容 

#--without-http_autoindex_module
# disable ngx_http_autoindex_module #自动生成目录列表，只在ngx_http_index_module模块未找到索引文件时发出请求。 

#--without-http_geo_module 
# disable ngx_http_geo_module #创建一些变量，其值依赖于客户端的IP地址 

#--without-http_map_module 
# disable ngx_http_map_module #使用任意的键/值对设置配置变量 

#--without-http_split_clients_module 
# disable ngx_http_split_clients_module #用来基于某些条件划分用户。条件如：ip地址、报头、cookies等等 

#--without-http_referer_module 
# disable ngx_http_referer_module #用来过滤请求，拒绝报头中Referer值不正确的请求 

#--without-http_rewrite_module 
# disable ngx_http_rewrite_module #允许使用正则表达式改变URI，并且根据变量来转向以及选择配置 

#--without-http_proxy_module 
# disable ngx_http_proxy_module #有关代理服务器 

#--without-http_fastcgi_module
# disable ngx_http_fastcgi_module #允许Nginx 与FastCGI 进程交互，并通过传递参数来控制FastCGI 进程工作。 

#--without-http_uwsgi_module  
# disable ngx_http_uwsgi_module #用来使用uwsgi协议，uWSGI服务器相关 

#--without-http_scgi_module
# disable ngx_http_scgi_module #用来启用SCGI协议支持，SCGI协议是CGI协议的替代。 

#--without-http_memcached_module
# disable ngx_http_memcached_module #用来提供简单的缓存，以提高系统效率 

#--without-http_limit_conn_module
# disable ngx_http_limit_conn_module #允许你对于一个地址进行连接数的限制用一个给定的session或一个特定的事件 

#--without-http_limit_req_module 
# disable ngx_http_limit_req_module #允许你对于一个地址进行请求数量的限制用一个给定的session或一个特定的事件 

#--without-http_empty_gif_module 
# disable ngx_http_empty_gif_module #在内存中常驻了一个1*1的透明GIF图像，可以被非常快速的调用 

#--without-http_browser_module 
# disable ngx_http_browser_module #用来创建依赖于请求报头的值 

#--without-http_upstream_hash_module 
# disable ngx_http_upstream_hash_module #用于简单的负载均衡 

#--without-http_upstream_ip_hash_module 
# disable ngx_http_upstream_ip_hash_module  

#--without-http_upstream_least_conn_module 
# disable ngx_http_upstream_least_conn_module  

#--without-http_upstream_keepalive_module 
# disable ngx_http_upstream_keepalive_module 

#--without-http_upstream_zone_module 
# disable ngx_http_upstream_zone_module 

#--with-http_perl_module 
# enable ngx_http_perl_module #这个模块允许nginx使用SSI调用perl或直接执行perl(使用会降低性能) 

#--with-http_perl_module=dynamic
# enable dynamic ngx_http_perl_module 

#--with-perl_modules_path=PATH
# set Perl modules path #设定perl模块路径 

#--with-perl=PATH
# set perl binary pathname #设定perl库文件路径 
  
#--http-log-path=PATH
# set http access log pathname #设定access log路径 

#--http-client-body-temp-path=PATH
# set path to store http client request body temporary files #设定http客户端请求临时文件路径 

#--http-proxy-temp-path=PATH
# set path to store http proxy temporary files #设定http代理临时文件路径 

#--http-fastcgi-temp-path=PATH
# set path to store http fastcgi temporary files #设定http fastcgi临时文件路径 

#--http-uwsgi-temp-path=PATH
# set path to store http uwsgi temporary files #设定http uwsgi临时文件路径 

#--http-scgi-temp-path=PATH
# set path to store http scgi temporary files #设定http scgi临时文件路径 

#--without-http 
# disable HTTP server #完全禁用http模块,如果只想支持mall,可以使用此项设置 

#--without-http-cache 
# disable HTTP cache #在使用upstream模块时,nginx能够配置本地缓存内容,此选项可禁用缓存 

#--with-mail  
# enable POP3/IMAP4/SMTP proxy module #激活POP3/IMAP4/SMTP代理模块,默认未激活 

#--with-mail=dynamic 
# enable dynamic POP3/IMAP4/SMTP proxy module 

#--with-mail_ssl_module  
# enable ngx_mail_ssl_module #SMTP可以使用SSL／TLS.配置已经定义了HTTP SSL模块，但是不支持客户端证书检测 

#--without-mail_pop3_module 
# disable ngx_mail_pop3_module #启用mail模块后,单独禁用pop3模块 

#--without-mail_imap_module  
# disable ngx_mail_imap_module #启用mail模块后,单独禁用imap模块 

#--without-mail_smtp_module 
# disable ngx_mail_smtp_module #启用mail模块后,单独禁用smtp模块 

#--with-stream 
# enable TCP/UDP proxy module 

#--with-stream=dynamic  
# enable dynamic TCP/UDP proxy module 

#--with-stream_ssl_module  
# enable ngx_stream_ssl_module 

#--without-stream_limit_conn_module 
# disable ngx_stream_limit_conn_module 

#--without-stream_access_module 
# disable ngx_stream_access_module 

#--without-stream_upstream_hash_module 
# disable ngx_stream_upstream_hash_module 

#--without-stream_upstream_least_conn_module 
# disable ngx_stream_upstream_least_conn_module 

#--without-stream_upstream_zone_module 
# disable ngx_stream_upstream_zone_module 

#--with-google_perftools_module
# enable ngx_google_perftools_module #调试用，剖析程序性能瓶颈 

#--with-cpp_test_module  
# enable ngx_cpp_test_module 

#--add-module=PATH    
# enable external module #启用外部模块支持 

#--add-dynamic-module=PATH  
# enable dynamic external module 

#---------编译相关的参数 

#--with-cc=PATH
# set C compiler pathname #如果想设置一个不在默认path下的c编译器 

#--with-cpp=PATH
# set C preprocessor pathname #设置c预处理器的相对路径 

#--with-cc-opt=OPTIONS  
# set additional C compiler options #设置C编译器参数 

#--with-ld-opt=OPTIONS
# set additional linker options #包含连接库的路径和运行路径 

#--with-cpu-opt=CPU  
# build for the specified CPU, valid values:pentium, pentiumpro, pentium3, pentium4,athlon, opteron, sparc32, sparc64, ppc64 #指定编译的CPU 
  
#--without-pcre 
# disable PCRE library usage #禁用pcre库 

#--with-pcre    
# force PCRE library usage #启用pcre库 

#--with-pcre=DIR
# set path to PCRE library sources #指向pcre库文件目录 

#--with-pcre-opt=OPTIONS   
# set additional build options for PCRE #在编译时为pcre库设置附加参数 

#--with-pcre-jit    
# build PCRE with JIT compilation support 

#--with-md5=DIR  
# set path to md5 library sources #指向md5库文件目录 

#--with-md5-opt=OPTIONS 
# set additional build options for md5 #在编译时为md5库设置附加参数 

#--with-md5-asm
# use md5 assembler sources #使用md5汇编源 

#--with-sha1=DIR
# set path to sha1 library sources #指向sha1库目录 

#--with-sha1-opt=OPTIONS
# set additional build options for sha1 #在编译时为sha1库设置附加参数 

#--with-sha1-asm   
# use sha1 assembler sources #使用sha1汇编源 

#--with-zlib=DIR  
# set path to zlib library sources #指向zlib库目录 

#--with-zlib-opt=OPTIONS
# set additional build options for zlib #在编译时为zlib设置附加参数 

#--with-zlib-asm=CPU  
# use zlib assembler sources optimized for the specified CPU, valid values: pentium, pentiumpro #为指定的CPU使用zlib汇编源进行优化 

#--with-libatomic 
# force libatomic_ops library usage # 为原子内存的更新操作的实现提供一个架构 

#--with-libatomic=DIR 
# set path to libatomic_ops library sources #指向libatomic_ops安装目录 

#--with-openssl=DIR 
# set path to OpenSSL library sources #指向openssl安装目录 

#--with-openssl-opt=OPTIONS 
# set additional build options for OpenSSL #在编译时为openssl设置附加参数 

#--with-debug 
# enable debug logging #启用debug日志

