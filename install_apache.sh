#! /bin/bash

install_apache(){

    if [ $(whereis -b httpd | tr ' ' '\n' | wc -l) -gt 1 ];then
        echo "Httpd has intalled in this machine";install
    else
        local url_path="http://mirrors.cnnic.cn/apache//httpd/httpd-2.4.23.tar.gz"
        local dir_name=$envpath"/apache"
        if [ ! -d $dir_name ];then 
            mkdir -p $dir_name 2> /dev/null
        fi
        if [ $? -eq 0 ];then
            cd $dir_name;
			#Apache Portable Runtime Project
			wget http://mirror.bit.edu.cn/apache/apr/apr-1.5.2.tar.gz
            tar zxvf apr-1.5.2.tar.gz
			cd apr-1.5.2
			./configure --prefix=/usr/local/apache/apr
			make && make install
			
			cd ..
			wget http://mirror.bit.edu.cn/apache/apr/apr-util-1.5.4.tar.gz
			tar zxvf apr-util-1.5.4.tar.gz
			cd apr-util-1.5.4
			./configure --prefix=/usr/local/apache/apr-util --with-apr=/usr/local/apache/apr
			make && make install
			
			cd ..
			wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz
			tar zxvf pcre-8.38.tar.gz
			cd pcre-8.38
			./configure 
			make && make install

			wget -c $url_path -O httpd-2.4.23.tar.gz;tar zxvf httpd-2.4.23.tar.gz
            cd httpd-2.4.23 
			./configure --prefix=/usr/local/apache \
						--with-apr=/usr/local/apache/apr/bin/apr-1-config \
						--with-apr-util=/usr/local/apache/apr-util/bin/apu-1-config \
						--enable-module=so \
						--enable-mods-shared=a \
						--enable-deflate \
						--enable-expires \
						--enable-headers \
						--enable-cache \
						--enable-file-cache \
						--enable-mem-cache \
						--enable-disk-cache \
						--enable-mime-magic \
						--enable-authn-dbm \
						--enable-vhost-alias \
						--enable-so \
						--enable-rewrite \
						--enable-ssl \
						--with-mpm=prefork
            make && make install;
            echo "Apache Complete install";
			install
        else
            echo "install apache faild"
        fi
    fi
}	
