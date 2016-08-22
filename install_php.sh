#! /bin/bash
install_php(){
    #if [ $(whereis -b php | tr ' ' '\n' | wc -l) -gt 1 ];then
	if [ $(php -v) -eq 0 ]; then
        echo "PHP has intalled in this machine";install
    else
        local url_path="http://cn2.php.net/get/php-5.5.38.tar.gz/from/this/mirror"
        local dir_name=$envpath"/php"
        if [ ! -d $dir_name ];then 
            mkdir -p $dir_name 2> /dev/null
        fi
        if [ $? -eq 0 ];then
            cd $dir_name;wget -c $url_path -O php-5.5.38.tar.gz;tar zxvf php-5.5.38.tar.gz
            cd php-5.5.38 

            ./configure \
            --prefix=/usr/local/php \
            --with-config-file-path=/etc/php \
            --enable-fpm --enable-pcntl \
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
            make && make install;cp ./php.ini-development /etc/php/
            echo "PHP Complete install";
			install
        else
            echo "install php faild"
        fi
    fi
}
