#! /bin/bash
install_php(){
    #if [ $(whereis -b php | tr ' ' '\n' | wc -l) -gt 1 ];then
	if [ $(php -v) -eq 0 ]; then
        echo "PHP has intalled in this machine";install
    else
        local url_path=$(get_ini php src)
        local dir_name=$(get_ini global dlPath)/$(get_ini php dir)
        if [ ! -d $dir_name ];then 
            mkdir -p $dir_name 2> /dev/null
        fi
        if [ $? -eq 0 ];then
            cd $dir_name;wget -c $url_path -O php-5.5.38.tar.gz;tar zxvf php-5.5.38.tar.gz
            cd php-5.5.38 

            ./configure \
            --prefix=$(get_ini global prefix) \
            --with-config-file-path=$(get_ini global confDir) \
            --enable-fpm \
            --enable-pcntl \
		    --enable-mysqlnd \
            --enable-opcache \
            --enable-sockets \
            --enable-sysvmsg \
            --enable-sysvsem \
			--enable-sysvshm \
            --enable-shmop \
            --enable-zip \
            --enable-ftp \
            --enable-soap \
            --enable-xml \
			--enable-mbstring \
            --disable-rpath \
            --disable-debug \
            --disable-fileinfo \
            --with-mysql=mysqlnd \
			--with-mysqli=mysqlnd \
            --with-pdo-mysql=mysqlnd \
            --with-pcre-regex \
            --with-iconv \
            --with-zlib \
		    --with-mcrypt \
            --with-gd \
            --with-openssl \
            --with-mhash \
            --with-xmlrpc \
            --with-curl \
            --with-imap-ssl
            make && make install
            ln -s $(get_ini global prefix)/$(get_ini php dir)/bin/php $(get_ini global prefix)/bin/php
            ln -s $(get_ini global prefix)/$(get_ini php dir)/sbin/php-fpm $(get_ini global prefix)/bin/php-fpm	
            ln -s $(get_ini global prefix)/etc/php-fpm.conf.default $(get_ini global confDir)/php-fpm.ini
            echo "PHP Complete install";
			install
        else
            echo "install php faild"
        fi
    fi
}
