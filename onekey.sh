#! /bin/bash
<<<<<<< HEAD

export envInit=0

#Git install
#wget -c https://github.com/git/git/archive/master.zip
#unzip master.zip
#cd git-master
#ln -sf /usr/local/bin/git /usr/bin/git
#git config --global user.name "murwen"
#git config --global user.email "murwenBing@hotmail.com"

#make && make install
init(){
=======
export envInit=0
init(){
    clear
>>>>>>> f14ee75d4beee66c63e4a8673f61bb0c09baf098
    ft l
    ft t "Centos 6.x Web Environment Deployment"
    ft t "OS: $(cat /etc/issue|head -n 1)"
    ft t "Kernel: $(uname -r)"
    ft t "Time: $(date)"
    ft t "Login User: $USER"
    ft t "Bash Version: $BASH_VERSION"
    ft t "Author: MurwenBing@hotmail.com"
    ft l
    export envpath=~/onekey;mkdir $envpath 2> /dev/null;
    install 
}
env_init(){
    if [ $envInit -eq 0 ]; then 
<<<<<<< HEAD
    yum install epel-release man gcc gdb qwt curl-devel expat-devel gettext-devel zlib-devel \
	gcc perl-ExtUtils-MakeMaker unzip gcc-c++ autoconf libjpeg libjpeg-devel libpng libpng-devel \
	freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel \
	bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel \
	libidn libidn-devel openssl openssl-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers \
	gd gd2 gd-devel gd2-devel perl-CPAN pcre-devel php-mcrypt libmcrypt libmcrypt-devel wget -y
=======
    yum install \
    epel-release man gcc gdb \
    qwt curl-devel expat-devel \
    gettext-devel zlib-devel \
	gcc perl-ExtUtils-MakeMaker \
    unzip gcc-c++ autoconf automake \
    libjpeg libjpeg-devel libpng libpng-devel \
	freetype freetype-devel libxml2 \
    libxml2-devel zlib zlib-devel glibc \
    glibc-devel glib2 glib2-devel \
	bzip2 bzip2-devel ncurses ncurses-devel \
    curl curl-devel e2fsprogs e2fsprogs-devel \
    krb5 krb5-devel libidn libidn-devel \
    openssl openssl-devel openldap \
    openldap-devel nss_ldap openldap-clients \
    openldap-servers gd gd2 gd-devel gd2-devel \
    perl-CPAN pcre-devel php-mcrypt libmcrypt \
    libmcrypt-devel wget libevent cmake libtool -y
>>>>>>> f14ee75d4beee66c63e4a8673f61bb0c09baf098
    envInit=1
    fi
}
install(){
    env_init;usage;
    case $? in
    1)
        install_all;;
    2)
        install_apache;;
    3)
<<<<<<< HEAD
        intall_nginx;;
=======
        install_nginx;;
>>>>>>> f14ee75d4beee66c63e4a8673f61bb0c09baf098
    4)
        install_php;;
    5)
        install_mysql;;
    6)
        install_redis;;
    7)
        install_memcache;;
<<<<<<< HEAD
=======
	8)
		install_git;;
>>>>>>> f14ee75d4beee66c63e4a8673f61bb0c09baf098
    *)
        install;;
    esac
}



usage(){
    sc "Do you want to install these for provide web service ?" g
<<<<<<< HEAD
    sc "(1:all 2:apache 3:nginx 4:php 5:mysql 6:redis 7:memcache)" g
    echo -n $(sc "Please choose your choice[1-7]:" g) 
=======
    sc "(1:all 2:apache 3:nginx 4:php 5:mysql 6:redis 7:memcache 8:git)" g
    echo -n $(sc "Please choose your choice[1-8]:" g) 
>>>>>>> f14ee75d4beee66c63e4a8673f61bb0c09baf098
    read choose
    return $choose
}
sc(){
    case $2 in 
    blue|b)
        echo -e "\e[1;34m $1 \e[0m";;
    red|r)
        echo -e "\e[1;31m $1 \e[0m";;
    yellow|y)
        echo -e "\e[1;33m $1 \e[0m";;
    green|g)
        echo -e "\e[1;32m $1 \e[0m";;
    *)      
        echo -e "\e[1;37m $1 \e[0m";;
    esac
}
ft(){
    case $1 in
    line|l)
<<<<<<< HEAD
        str=$(printf "%-80s" "-");echo "+${str// /-}";;
=======
        str=$(printf "%-102s" "-");echo "+${str// /-}";;
>>>>>>> f14ee75d4beee66c63e4a8673f61bb0c09baf098
    text|t)
        str=$(printf  "%5s" $2);echo "+${str}";;
    *)
        echo -e "\t\t $2";;
    esac
}
#PHP install
install_all(){
:
}
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

<<<<<<< HEAD
            ./configure --prefix=/usr/local/php --with-config-file-path=/etc/php --enable-fpm --enable-pcntl \
						--enable-mysqlnd --enable-opcache --enable-sockets --enable-sysvmsg --enable-sysvsem \
						--enable-sysvshm --enable-shmop --enable-zip --enable-ftp --enable-soap --enable-xml \
						--enable-mbstring --disable-rpath --disable-debug --disable-fileinfo --with-mysql=mysqlnd \
						--with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-pcre-regex --with-iconv --with-zlib \
						--with-mcrypt --with-gd --with-openssl --with-mhash --with-xmlrpc --with-curl --with-imap-ssl            
=======
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
>>>>>>> f14ee75d4beee66c63e4a8673f61bb0c09baf098
            make && make install;cp ./php.ini-development /etc/php/
            echo "PHP Complete install";
			install
        else
            echo "install php faild"
        fi
    fi
}
#Nginx Install
install_nginx(){
<<<<<<< HEAD
:
=======
	

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
	
>>>>>>> f14ee75d4beee66c63e4a8673f61bb0c09baf098
}

#Apache Install
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
#Mysql Install
install_mysql(){
<<<<<<< HEAD
:
}
#Redis Install
install_redis(){
:
}
#Memcache Install
install_memcache(){
:
=======
    if [ $(whereis -b mysqld | tr ' ' '\n' | wc -l) -gt 1 ];then
        echo "mysql has intalled in this machine";install
    else
        local url_path="http://dev.mysql.com/get/Downloads/MySQL-5.5/mysql-5.5.51.tar.gz"
        local dir_name=$envpath"/mysql"
        if [ ! -d $dir_name ];then 
            mkdir -p $dir_name 2> /dev/null
        fi
        if [ $? -eq 0 ];then
            cd $dir_name;
			wget $url_path 
			tar zxvf mysql-5.5.51.tar.gz
			cd mysql-5.5.51 
			cmake \
			-DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
			-DMYSQL_DATADIR=/usr/local/mysql/data \
			-DSYSCONFDIR=/etc \
			-DWITH_MYISAM_STORAGE_ENGINE=1 \
			-DWITH_INNOBASE_STORAGE_ENGINE=1 \
			-DWITH_MEMORY_STORAGE_ENGINE=1 \
			-DWITH_READLINE=1 \
			-DMYSQL_UNIX_ADDR=/var/lib/mysql/mysql.sock \
			-DMYSQL_TCP_PORT=3306 \
			-DENABLED_LOCAL_INFILE=1 \
			-DWITH_PARTITION_STORAGE_ENGINE=1 \
			-DEXTRA_CHARSETS=a \
			-DDEFAULT_CHARSET=utf8 \
			-DDEFAULT_COLLATION=utf8_general_ci
			make && make install
            echo "Redis Complete install";
			install
        else
            echo "install redis faild"
        fi
    fi
}
#Redis Install
install_redis(){

    if [ $(whereis -b redis | tr ' ' '\n' | wc -l) -gt 1 ];then
        echo "redis has intalled in this machine";install
    else
        local url_path="http://download.redis.io/releases/redis-3.2.3.tar.gz"
        local dir_name=$envpath"/redis"
        if [ ! -d $dir_name ];then 
            mkdir -p $dir_name 2> /dev/null
        fi
        if [ $? -eq 0 ];then
            cd $dir_name;
			wget $url_path 
			tar xzf redis-3.2.3.tar.gz
			cd redis-3.2.3	
			make
            echo "Redis Complete install";
			install
        else
            echo "install redis faild"
        fi
    fi
}
#Memcache Install
install_memcache(){

    if [ $(whereis -b memcached | tr ' ' '\n' | wc -l) -gt 1 ];then
        echo "memcached has intalled in this machine";install
    else
		wget https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz
		tar zxvf libevent-2.0.22-stable.tar.gz
		cd libevent-2.0.22-stable
		make && make install
		
		ln -s /usr/local/lib/libevent-2.0.so.5 /usr/lib64/libevent-2.0.so.5
		
        local url_path="http://memcached.org/files/memcached-1.4.31.tar.gz"
        local dir_name=$envpath"/memcache"
        if [ ! -d $dir_name ];then 
            mkdir -p $dir_name 2> /dev/null
        fi
        if [ $? -eq 0 ];then
            cd $dir_name;
			wget $url_path 
			tar zxvf memcached-1.4.31.tar.gz 
			cd memcached-1.4.31	
			./configure && make && make test && sudo make install
            echo "Memcached Complete install";
			install
        else
            echo "install Memcached faild"
        fi
    fi
}
install_git(){

    if [ $(whereis -b gits | tr ' ' '\n' | wc -l) -gt 1 ];then
        echo "git has intalled in this machine";install
    else
		
        local url_path="https://github.com/git/git/archive/v2.9.3.zip"
        local dir_name=$envpath"/git"
        if [ ! -d $dir_name ];then 
            mkdir -p $dir_name 2> /dev/null
        fi
        if [ $? -eq 0 ];then
            cd $dir_name;
			wget $url_path 
			unzip v2.9.3.zip	
			cd git-2.9.3	
            autoconf
			./configure && make && make install
            echo "Git Complete install";
			install
        else
            echo "install git faild"
        fi
    fi
>>>>>>> f14ee75d4beee66c63e4a8673f61bb0c09baf098
}
init
