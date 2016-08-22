#! /bin/bash
install_nginx(){
    if [ $(whereis -b nginx | tr ' ' '\n' | wc -l) -gt 1 ];then
        echo "nginx has intalled in this machine";install
    else
        local url_path="http://nginx.org/download/nginx-1.10.1.tar.gz"
        local dir_name=$envpath"/nginx"
        if [ ! -d $dir_name ];then 
            mkdir -p $dir_name 2> /dev/null
        fi
        if [ $? -eq 0 ];then
            cd $dir_name;
			wget $url_path 
			tar xzf nginx-1.10.1.tar.gz
			cd nginx-1.10.1	
			./configure \
			--prefix=/usr \
			--sbin-path=/usr/sbin/nginx \
			--conf-path=/etc/nginx/nginx.conf \
			--error-log-path=/var/log/nginx/error.log \
			--pid-path=/var/run/nginx/nginx.pid \
			--user=nginx \
			--group=nginx \
			--with-http_ssl_module \
			--with-http_flv_module \
			--with-http_gzip_static_module \
			--http-proxy-temp-path=/var/tmp/nginx/proxy \
			--http-fastcgi-temp-path=/var/tmp/nginx/fcgi \
			--with-http_stub_status_module
			make && make install
			mkdir -p /var/tmp/nginx/client
            echo "Nginx Complete install";
			install
        else
            echo "install Nginx faild"
        fi
    fi
	
}
