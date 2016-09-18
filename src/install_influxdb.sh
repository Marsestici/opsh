#! /bin/bash

install_influxdb(){
    if [ $(whereis -b influxd| tr ' ' '\n' | wc -l) -gt 1 ];then
        echo "influxdb has intalled in this machine";install
    else
        local url_path=$(get_ini influxdb src)
        local dir_name=$(get_ini global dlPath)/$(get_ini influxdb dir)
        if [ ! -d $dir_name ];then 
            mkdir -p $dir_name 2> /dev/null
        fi
        if [ $? -eq 0 ];then
            cd $dir_name;
			wget $url_path 
            yum localinstall influxdb-1.0.0.x86_64.rpm -y
            sed -i '/:OUTPUT/a\-A INPUT -m state --state NEW -m tcp -p tcp --dport 8083 -j ACCEPT' /etc/sysconfig/iptables
            sed -i '/:OUTPUT/a\-A INPUT -m state --state NEW -m tcp -p tcp --dport 8086 -j ACCEPT' /etc/sysconfig/iptables
            sed -i '/:OUTPUT/a\-A INPUT -m state --state NEW -m tcp -p tcp --dport 8088 -j ACCEPT' /etc/sysconfig/iptables
    	    service iptables restart
 
            echo "influxdb Complete install";
			install
        else
            echo "install influxdb faild"
        fi
    fi
}
