#! /bin/bash

install_mysql(){
    if [ $(whereis -b mysqld | tr ' ' '\n' | wc -l) -gt 1 ];then
        echo "mysql has intalled in this machine";install
    else
        local url_path=$(get_ini mysql src)
        local dir_name=$(get_ini global dlPath)/$(get_ini mysql dir)
        if [ ! -d $dir_name ];then 
            mkdir -p $dir_name 2> /dev/null
        fi
        if [ $? -eq 0 ];then
            cd $dir_name;
			wget $url_path 
			tar zxvf mysql-5.5.51.tar.gz
			cd mysql-5.5.51 
			cmake \
            -DCMAKE_INSTALL_PREFIX=$(get_ini global prefix)/$(get_ini mysql dir) \
            -DMYSQL_DATADIR=$(get_ini global prefix)/$(get_ini mysql dir)/data \
            -DSYSCONFDIR=$(get_ini global confDir) \
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
            echo "Mysql Complete install";
			install
        else
            echo "install mysql faild"
        fi
    fi
}
