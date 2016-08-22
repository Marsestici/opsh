#! /bin/bash

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
