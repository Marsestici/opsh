#! /bin/bash

install_mysql(){
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
