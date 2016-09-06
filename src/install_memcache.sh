#! /bin/bash

install_memcache(){
    
    if [ 1 -ne 1 ];then
    #if [ $(whereis -b memcached | tr ' ' '\n' | wc -l) -gt 1 ];then
        echo "memcached has intalled in this machine";install
    else
        local url_path=$(get_ini memcache libeve)
        local dir_name=$(get_ini global dlPath)/$(get_ini memcache dir)
        if [ ! -d $dir_name ];then
            mkdir -p $dir_name 2> /dev/null
        fi
        cd $dir_name
        wget $(get_ini memcache libeve)
		tar zxvf libevent-2.0.22-stable.tar.gz
		cd libevent-2.0.22-stable
		make && make install
		
		ln -s /usr/local/lib/libevent-2.0.so.5 /usr/lib64/libevent-2.0.so.5
	    cd ..
        local url_path=$(get_ini memcache src)
        local dir_name=$(get_ini global dlPath)/$(get_ini memcache dir)
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
