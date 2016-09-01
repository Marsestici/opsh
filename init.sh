#! /bin/bash
. ./install_php.sh
. ./install_apache.sh
. ./install_nginx.sh
. ./install_redis.sh
. ./install_memcache.sh
. ./install_mysql.sh
. ./install_git.sh
init(){
    clear
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
        install_nginx;;
    4)
        install_php;;
    5)
        install_mysql;;
    6)
        install_redis;;
    7)
        install_memcache;;
	8)
		install_git;;
    *)
        install;;
    esac
}



usage(){
    sc "Do you want to install these for provide web service ?" g
    sc "(1:all 2:apache 3:nginx 4:php 5:mysql 6:redis 7:memcache 8:git)" g
    echo -n $(sc "Please choose your choice[1-8]:" g) 
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
        str=$(printf "%-102s" "-");echo "+${str// /-}";;
    text|t)
        str=$(printf  "%5s" $2);echo "+${str}";;
    *)
        echo -e "\t\t $2";;
    esac
}
