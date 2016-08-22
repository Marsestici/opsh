#! /bin/bash
dlPath=$(get_ini global dlPath)
dir=$(get_ini apache dir)
prefix=$(get_ini global prefix)
dlAbsPath=$dlPath/$dir
mtAbsPath=$prefix/$dir
install_apache(){

    if [ $(whereis -b httpd | tr ' ' '\n' | wc -l) -gt 1 ];then
        echo "Httpd has intalled in this machine";install
    else
        local url_path=$(get_ini apache src)
        local dir_name=$dlAbsPath
        if [ ! -d $dir_name ];then 
            mkdir -p $dir_name 2> /dev/null
        fi
        if [ $? -eq 0 ];then
            cd $dir_name;
			#Apache Portable Runtime Project
            wget $(get_ini apache apr)
            tar zxvf apr-1.5.2.tar.gz
			cd apr-1.5.2
            ./configure --prefix=$mtAbsPath/apr
			make && make install
			
			cd ..
            wget $(get_ini apache aprUtil)
			tar zxvf apr-util-1.5.4.tar.gz
			cd apr-util-1.5.4
            ./configure --prefix=$mtAbsPath/apr/apr-util --with-apr=$mtAbsPath/apr
			make && make install
			
			cd ..
            wget $(get_ini apache pcre)
			tar zxvf pcre-8.38.tar.gz
			cd pcre-8.38
			./configure --prefix=$prefix
			make && make install

			wget -c $url_path -O httpd-2.4.23.tar.gz;tar zxvf httpd-2.4.23.tar.gz
            cd httpd-2.4.23 
            ./configure --prefix=$mtAbsPath \
                        --with-apr=$mtAbsPath/apr/bin/apr-1-config \
                        --with-apr-util=$mtAbsPath/apr-util/bin/apu-1-config \
                        --sysconfdir=$(get_ini global confDir)
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
                        --with-mpm=$(get_ini apache mpm)
            make && make install;
	    #ln -s /usr/local/apache/conf/httpd.conf /etc/httpd.conf
        sed -i '/mod_proxy.so/s/#//' $(get_ini global confDir)/httpd.conf
        sed -i '/mod_proxy_fcgi.so/s/#//' $(get_ini global confDir)/httpd.conf

	    sed -i '$a\
		<FilesMatch \\.php$>\
			SetHandle "proxy:fcgi://127.0.0.1:9000"\
            </FilesMatch>' $(get_ini global confDir)/httpd.conf
	    sed -i '/COMMIT/i\-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT' /etc/sysconfig/iptables
	    service iptables restart
            echo "Apache Complete install";
			install
        else
            echo "install apache faild"
        fi
    fi
}	
