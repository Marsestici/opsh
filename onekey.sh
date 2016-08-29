#! /bin/bash

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
    yum install epel-release man gcc gdb qwt curl-devel expat-devel gettext-devel zlib-devel \
	gcc perl-ExtUtils-MakeMaker unzip gcc-c++ autoconf libjpeg libjpeg-devel libpng libpng-devel \
	freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel \
	bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel \
	libidn libidn-devel openssl openssl-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers \
	gd gd2 gd-devel gd2-devel perl-CPAN pcre-devel php-mcrypt libmcrypt libmcrypt-devel wget -y
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
        intall_nginx;;
    4)
        install_php;;
    5)
        install_mysql;;
    6)
        install_redis;;
    7)
        install_memcache;;
    *)
        install;;
    esac
}



usage(){
    sc "Do you want to install these for provide web service ?" g
    sc "(1:all 2:apache 3:nginx 4:php 5:mysql 6:redis 7:memcache)" g
    echo -n $(sc "Please choose your choice[1-7]:" g) 
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
        str=$(printf "%-80s" "-");echo "+${str// /-}";;
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

            ./configure --prefix=/usr/local/php --with-config-file-path=/etc/php --enable-fpm --enable-pcntl \
						--enable-mysqlnd --enable-opcache --enable-sockets --enable-sysvmsg --enable-sysvsem \
						--enable-sysvshm --enable-shmop --enable-zip --enable-ftp --enable-soap --enable-xml \
						--enable-mbstring --disable-rpath --disable-debug --disable-fileinfo --with-mysql=mysqlnd \
						--with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-pcre-regex --with-iconv --with-zlib \
						--with-mcrypt --with-gd --with-openssl --with-mhash --with-xmlrpc --with-curl --with-imap-ssl            
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
:
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
:
}
#Redis Install
install_redis(){
:
}
#Memcache Install
install_memcache(){
:
}
init
